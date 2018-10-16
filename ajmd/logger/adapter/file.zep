namespace Ajmd\Logger\Adapter;

use Ajmd\Logger\Adapter;
use Ajmd\Logger\Exception;
use Ajmd\Logger\FormatterInterface;
use Ajmd\Logger\Formatter\Line as LineFormatter;

class File extends Adapter
{
    protected _fileHandler;

    protected _path { get };

    protected _options;

    public function __construct(string! name, options = null)
    {
        var mode = null,handler;
        if typeof options === "array" {
            if fetch mode, options["mode"] {
                if memstr(mode,"r") {
                    throw new Exception(" Logger must be opened in append or write mode");
                }
            }
        }

        if mode === null {
            let mode = "ab";
        }

        let handler = fopen(name, mode);
        if typeof handler !== "resource" {
            throw new Exception("Can't open log file at '". name ."'");
        }

        let this->_path = name;
        let this->_options = options;
        let this->_fileHandler = handler;
    }

    public function getFormatter() -> <FormatterInterface>
    {
        if typeof this->_formatter !== "object" {
            let this->_formatter = new LineFormatter;
        }

        return this->_formatter;
    }

    public function logInternal(string message, int type, int timestamp, array context) -> void
    {
        var fileHandler;
        let fileHandler = this->_fileHandler;
        if typeof fileHandler !== "resource" {
            throw new Exception(" Can't send message to the log because it is invalid");
        }

        fwrite(fileHandler,this->getFormatter()->format(message,type,timestamp,context));
    }

    public function close() -> boolean
    {
        return fclose(this->_fileHandler);
    }

    public function __wakeup()
    {
        var path,mode;
        let path = this->_path;
        if typeof path !== "string" {
            throw new Exception("Invalid data passed to Ajmd\\Logger\\Adapter\\File::__wakeup()");
        }

        if !fetch mode,this->_options["mode"] {
            let mode = "ab";
        }

        if typeof mode !== "string" {
            throw new Exception("Invalid data passed to Ajmd\\Logger\\Adapter\\File::__wakeup()");
        }

        if memstr(mode, "r") {
            throw new Exception("Logger must be opened in append or write mode");
        }

        let this->_fileHandler = fopen(path,mode);
    }
}