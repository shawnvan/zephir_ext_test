namespace Ajmd\Logger\Formatter;

use Ajmd\Logger\Formatter;

class Json extends Formatter
{
    public function format(string message, int type, int timestamp, var context = null) -> string
    {
        if typeof context === "array" {
            let message = this->interpolate(message, context);
        }
        
        return json_encode([
            "type": this->getTypeString(type),
            "message": message,
            "timestamp": timestamp
        ]).PHP_EOL;
    }
}