

namespace Ajmd\Logger\Formatter;

use Ajmd\Logger\Formatter;

/**
 * Ajmd\Logger\Formatter\Syslog
 *
 * Prepares a message to be used in a Syslog backend
 */
class Syslog extends Formatter
{

	/**
	 * Applies a format to a message before sent it to the internal log
	 *
	 * @param string message
	 * @param int type
	 * @param int timestamp
	 * @param array context
	 * @return array
	 */
	public function format(string message, int type, int timestamp, var context = null)
	{
		if typeof context === "array" {
			let message = this->interpolate(message, context);
		}
		return [message];
	}
}
