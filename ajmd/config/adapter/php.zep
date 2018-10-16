namespace Ajmd\Config\Adapter;

use Ajmd\Config;

class Php extends Config
{
	public function __construct(string! filePath)
	{
		parent::__construct(require filePath);
	}
}