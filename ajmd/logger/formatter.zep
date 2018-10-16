namespace Ajmd\Logger;

use Ajmd\Logger;

abstract class Formatter implements FormatterInterface
{
   /**
	 * Returns the string meaning of a logger constant
	 */
	public function getTypeString(int type) -> string
	{
		switch type {

			case Logger::DEBUG:
				return "DEBUG";

			case Logger::ERROR:
				return "ERROR";

			case Logger::WARNING:
				return "WARNING";

			case Logger::CRITICAL:
				return "CRITICAL";

			case Logger::CUSTOM:
				return "CUSTOM";

			case Logger::ALERT:
				return "ALERT";

			case Logger::NOTICE:
				return "NOTICE";

			case Logger::INFO:
				return "INFO";

			case Logger::EMERGENCY:
				return "EMERGENCY";

			case Logger::SPECIAL:
				return "SPECIAL";
		}

		return "CUSTOM";
	}

	/**
	 * Interpolates context values into the message placeholders
	 *
	 * @see http://www.php-fig.org/psr/psr-3/ Section 1.2 Message
	 * @param string $message
	 * @param array $context
	 */
	public function interpolate(string message, var context = null)
	{
		var replace, key, value;

		if typeof context == "array" && count(context) > 0 {
			let replace = [];
			for key, value in context {
				let replace["{" . key . "}"] = value;
			}
			return strtr(message, replace);
		}
		return message;
	} 
}