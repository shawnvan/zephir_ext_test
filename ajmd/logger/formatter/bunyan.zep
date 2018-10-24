namespace Ajmd\Logger\Formatter;


use Ajmd\Logger\Formatter;
use Ajmd\Logger;

class Bunyan extends Formatter
{
    //{"name":"account","hostname":"dev-ms-p-api3","pid":7301,"id":"ctx","level":30,"ctx":{"apiName":"GetUserTitle","requestId":"2d0b5465-b3bd-41cc-8f2d-2a05e9671b45","correlationId":"dde661ab-f480-4986-911b-11117a2289c0","previousRequestId":"a37c6474-4400-4a10-b1ad-a769b63a2811"},"responseTime":1538215076964,"duration":5,"msg":"end ServerContext","time":"2018-09-29T09:57:56.964Z","v":0}
    protected _dateFormat = "D, d M y H:i:s O" { get, set };

    protected _bunyanEvent = [] {get,set};

    protected _correlationId;

    const BUNYAN_VERSION = 0;

    /**
     * The service/app is going to stop or become unusable now - An operator should definitely look into this soon
     * @var int
     */
    const LEVEL_FATAL = 60;

    /**
     * Fatal for a particular request, but the service/app continues servicing other requests
     * An operator should look at this soon(ish)
     * @var int
     */
    const LEVEL_ERROR = 50;

    /**
     * A note on something that should probably be looked at by an operator eventually
     * @var int
     */
    const LEVEL_WARN = 40;

    /**
     * Detail on regular operation
     * @var int
     */
    const LEVEL_INFO = 30;

    /**
     * Anything else, i.e. too verbose to be included in "info" level
     * @var int
     */
    const LEVEL_DEBUG = 20;

    /**
     * Logging from external libraries used by your app or very detailed application logging
     * @var int
     */
    const LEVEL_TRACE = 10;

    public function __construct()
    {
        let this->_requestId = uniqid();
    }

    public function format(string message, int type, int timestamp, var context =  null) -> string
    {
        
        if typeof context !== "array" {
            let context = [];
        }
       
        //{"name":"hello","hostname":"banana.local","pid":40026,"level":30,"msg":"hi paul","time":"2012-03-28T17:25:37.050Z","v":0}
        //
        let this->_bunyanEvent = [
            "name": "ajmd",
            "correlationId" : this->_correlationId,
            "level": this->_logLevelMapping(type),
            "msg": message,
            "hostname" : gethostname(),
            "context": context,
            "pid": getmypid(),
            "time": this->_formateTime(timestamp),
            "v": self::BUNYAN_VERSION
        ];

		return json_encode(this->_bunyanEvent).PHP_EOL;
    }

    private function _formateTime(int timestamp) -> string
    {
        date_default_timezone_set("Asia/Shanghai");
        return date(this->_dateFormat,timestamp);
    }

    private function _logLevelMapping(int type) -> int
    {
        switch type {
            case Logger::DEBUG:
				return self::LEVEL_DEBUG;

			case Logger::ERROR:
				return self::LEVEL_ERROR;

			case Logger::WARNING:
				return self::LEVEL_WARN;

			case Logger::CRITICAL:
				return self::LEVEL_ERROR;

			case Logger::ALERT:
				return self::LEVEL_FATAL;

			case Logger::NOTICE:
				return self::LEVEL_INFO;

			case Logger::INFO:
				return self::LEVEL_INFO;

			case Logger::EMERGENCY:
				return self::LEVEL_FATAL;

        }
        return self::LEVEL_INFO;
    }
}