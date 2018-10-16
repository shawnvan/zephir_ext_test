namespace Ajmd\Logger;
interface FormatterInterface
{
    /**
	 * Applies a format to a message before sent it to the internal log
	 *
	 * @param var message
	 * @param int type
	 * @param int timestamp
	 * @param array $context
	 */
	public function format(string message, int type, int timestamp, var context = null);
}