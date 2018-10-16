namespace Ajmd\Logger\Adapter;

use Ajmd\Logger\Adapter;
use Ajmd\Logger\Formatter\Line;
use Ajmd\Logger\Formatter\FormatterInterface;

class Blackhole extends Adapter
{
    /**
	 * Returns the internal formatter
	 */
	public function getFormatter() 
	{
		if typeof this->_formatter !== "object" {
			let this->_formatter = new Line();
		}

		return this->_formatter;
	}

    public function logInternal(string message, int type, int timestamp, array context) -> void
    {

    }

    public function close() -> boolean
    {

    }
}