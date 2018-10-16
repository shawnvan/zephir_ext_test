namespace Ajmd\Logger;

class Item
{
    /**
	 * Log type
	 *
	 * @var integer
	 */
	protected _type { get };

	/**
	 * Log message
	 *
	 * @var string
	 */
	protected _message { get };

	/**
	 * Log timestamp
	 *
	 * @var integer
	 */
	protected _time { get };

	protected _context { get };

	/**
	 * Phalcon\Logger\Item constructor
	 *
	 * @param string $message
	 * @param integer $type
	 * @param integer $time
	 * @param array $context
	 */
	public function __construct(string message, int type, int time = 0, var context = null)
	{
		let this->_message = message,
			this->_type = type,
			this->_time = time;

		if typeof context == "array" {
			let this->_context = context;
		}
	}
}