<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
// ------------------------------------------------------------------------

/**
 * CodeIgniter Error Helpers
 *
 * @package		CodeIgniter
 * @subpackage	Helpers
 * @category	Helpers
 * @author		ExpressionEngine Dev Team
 * @link		http://codeigniter.com/user_guide/helpers/currency_helper.html
 */

// ------------------------------------------------------------------------

/**
 * Default Currency
 *
 * Fetches the default currency from Database
 *
 * @access	public
 * @param	null
 * @return	string
 */
if ( ! function_exists('sem'))
{
	function sem($msg='', $f=1, $log=0, $show=1)
	{
		$ci =& get_instance();
		$ci->load->library('Actions');
		$ci->actions->sem($msg,$f,$log,$show);
	}
}

if ( ! function_exists('gem'))
{
	function gem()
	{
		$ci =& get_instance();
		$ci->load->library('Actions');
		$ci->actions->gem();
	}
}


/* End of file error_helper.php */
/* Location: ./system/helpers/error_helper.php */
