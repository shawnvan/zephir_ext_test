namespace Ajmd\Logger;

interface AdapterInterface
{
    /**
	 * Sets the message formatter
	 */
	public function setFormatter(<FormatterInterface> formatter) -> <AdapterInterface>;

	/**
	 * Returns the internal formatter
	 */
	public function getFormatter();

	/**
	 * Filters the logs sent to the handlers to be greater or equals than a specific level
	 */
	public function setLogLevel(int level) -> <AdapterInterface>;

	/**
	 * Returns the current log level
	 */
	public function getLogLevel() -> int;

	/**
	 * Sends/Writes messages to the file log
	 */
	public function log(var type, var message = null, array! context = null) -> <AdapterInterface>;

	/**
 	 * Starts a transaction
 	 */
	public function begin() -> <AdapterInterface>;

	/**
 	 * Commits the internal transaction
 	 */
	public function commit() -> <AdapterInterface>;

	/**
 	 * Rollbacks the internal transaction
 	 */
	public function rollback() -> <AdapterInterface>;

	/**
 	 * Closes the logger
 	 */
	public function close() -> boolean;

	/**
 	 * Sends/Writes a debug message to the log
 	 */
	public function debug(string! message, array! context = null) -> <AdapterInterface>;

	/**
 	 * Sends/Writes an error message to the log
 	 */
	public function error(string! message, array! context = null) -> <AdapterInterface>;

	/**
 	 * Sends/Writes an info message to the log
 	 */
	public function info(string! message, array! context = null) -> <AdapterInterface>;

	/**
 	 * Sends/Writes a notice message to the log
 	 */
	public function notice(string! message, array! context = null) -> <AdapterInterface>;

	/**
 	 * Sends/Writes a warning message to the log
 	 */
	public function warning(string! message, array! context = null) -> <AdapterInterface>;

	/**
 	 * Sends/Writes an alert message to the log
 	 */
	public function alert(string! message, array! context = null) -> <AdapterInterface>;

	/**
 	 * Sends/Writes an emergency message to the log
 	 */
	public function emergency(string! message, array! context = null) -> <AdapterInterface>;
}