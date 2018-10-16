namespace Ajmd;

interface FactoryInterface
{
	/**
	 * @param \Ajmd\Config|array $[config] [<description>]
	 */
	public static function load(var config);
}