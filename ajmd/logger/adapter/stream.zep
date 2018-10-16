namespace Ajmd\Logger\Adapter;

use Ajmd\Logger\Exception;
use Ajmd\Logger\Adapter;
use Ajmd\Logger\FormatterInterface;
use Ajmd\Logger\Formatter\Line as LineFormatter;

class Stream extends Adapter
{
    protected _stream;

    public function __construct(string! name, options = null)
    {
        var mode, stream;
        if fetch mode,options["mode"] {
            if memstr(mode,"r") {
                throw new Exception("Stream must be opened in append or write mode");
            }
        } else {
            let mode = "ab";
        }

        let stream = fopen(name,mode);
        if !stream {
            throw new Exception(" Can't open stream '" . name . " '");
        }

        let this->_stream = stream;
    }

    public function getFormatter()
    {
        if typeof this->_formatter !== "object" {
            let this->_formatter = new LineFormatter();
        }

        return this->_formatter;
    }

    public function logInternal(string message, int type, int timestamp, array context) {
        var stream;
        let stream = this->_stream;

        if typeof stream !== "resource" {
            throw new Exception("Can't send message ot the log because it is invalid");
        } 
        fwrite(stream,this->getFormatter()->format(message, type, timestamp, context));
    }

    public function close() -> boolean
    {
        return fclose(this->_stream);
    }
}