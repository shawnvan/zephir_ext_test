namespace Ajmd\Logger\Adapter;

use Ajmd\Logger\Exception;
use Ajmd\Logger\Adapter;
use Ajmd\Logger\Formatter\Syslog as SyslogFormatter;

class Syslog extends Adapter
{
    protected _opened = false;

    public function __construct(name, options = null)
    {
        var option, facility;

        if name {
            if !fetch option, options["option"] {
                let option = LOG_ODELAY;
            }

            if !fetch facility, options["facility"] {
                let facility = LOG_USER;
            }

            openlog(name,option,facility);

            let this->_opened = true;
        }
    }

    public function getFormatter()
    {
        if typeof this->_formatter !== "object" {
            let this->_formatter = new SyslogFormatter();
        }

        return this->_formatter;
    }

    public function logInternal(string message, int type, int timestamp, array context)
    {
        var appliedFomat;

        let appliedFomat = this->getFormatter()->format(message,type,timestamp,context);
        if typeof appliedFomat !== "array" {
            throw new Exception("The formatted message is not valid");
        }

        syslog(appliedFomat[0], appliedFomat[1]);
    }

    public function close() -> boolean
    {
        if !this->_opened {
            return true;
        }
        return closelog();
    }
}