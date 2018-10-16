namespace Ajmd\Config\Adapter;

use Ajmd\Config;

class Json extends Config
{
	public function __construct(string! filePath)
	{
		parent::__construct(json_decode(file_get_contents(filePath),true));
	}
}