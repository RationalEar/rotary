<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class User_Model extends CI_Model
{

	function __construct()
	{
		parent::__construct();
		$this->load->config('auth', TRUE);
		$this->autharray = $this->config->item('auth');
		//print_r($this->auth);
		
		###++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++###
		//$this->auth = new stdClass;
		
		// Sessions and cookies
		$this->auth->session_name = $this->config->item('sessions','auth');
		$this->auth->cookie_name = $this->config->item('cookies','auth');
	
		// Get the current auth session, else get the default values
		if ($this->session->userdata($this->auth->session_name['name']) !== FALSE)
		{
			$this->auth->session_data = $this->session->userdata($this->auth->session_name['name']);
		}
		else
		{
			$this->auth->session_data = $this->set_auth_defaults();
		}
		
		// Database tables and settings
		$this->auth->database_config = $database_config = $this->config->item('database','auth');

		// Prefix each table column with the name of the parent table. 
		foreach($database_config as $table_key => $table_data)
		{
			if (! empty($table_data['table']) && ! empty($table_data['columns']))
			{
				foreach($table_data['columns'] as $column_reference => $column_name)
				{
					$database_config[$table_key]['columns'][$column_reference] = $table_data['table'].'.'.$column_name;
				}

				if (! empty($table_data['custom_columns']))
				{
					$database_config[$table_key]['custom_columns'] = array();

					foreach($table_data['custom_columns'] as $column_reference => $column_name)
					{
						$database_config[$table_key]['custom_columns'][$column_name] = $table_data['table'].'.'.$column_name;
					}
				}
			}
			// Prefix the primary key, foreign key and custom columns of any custom tables. 
			else if ($table_key == 'custom')
			{
				foreach($table_data as $custom_table_key => $table_data)
				{
					if (! empty($table_data['table']) && ! empty($table_data['primary_key']))
					{
						$database_config['custom'][$custom_table_key]['primary_key'] = $table_data['table'].'.'.$table_data['primary_key'];
					}
					if (! empty($table_data['table']) && ! empty($table_data['foreign_key']))
					{
						$database_config['custom'][$custom_table_key]['foreign_key'] = $table_data['table'].'.'.$table_data['foreign_key'];
					}
					if (! empty($table_data['table']) && ! empty($table_data['custom_columns']))
					{
						foreach($table_data['custom_columns'] as $column_reference => $column_name)
						{
							$database_config['custom'][$custom_table_key]['custom_columns'][$column_reference] =  $table_data['table'].'.'.$column_name;
						}
					}
				}
			}
		}

		// User session table
		$this->auth->tbl_user_session = $database_config['user_sess']['table'];
		$this->auth->tbl_join_user_session = $database_config['user_sess']['join'];
		$this->auth->tbl_col_user_session = $database_config['user_sess']['columns'];
		
		// User group table
		$this->auth->tbl_user_group = $database_config['user_group']['table'];
		$this->auth->tbl_join_user_group = $database_config['user_group']['join'];
		$this->auth->tbl_col_user_group = $database_config['user_group']['columns'];
		
		// User privilege tables
		$this->auth->tbl_user_privilege = $database_config['user_privileges']['table'];
		$this->auth->tbl_col_user_privilege = $database_config['user_privileges']['columns'];
		$this->auth->tbl_user_privilege_users = $database_config['user_privilege_users']['table'];
		$this->auth->tbl_col_user_privilege_users = $database_config['user_privilege_users']['columns'];
		
		// User group privilege tables
		$this->auth->tbl_user_privilege_groups = $database_config['user_privilege_groups']['table'];
		$this->auth->tbl_col_user_privilege_groups = $database_config['user_privilege_groups']['columns'];
		
		// User main account table
		$this->auth->tbl_user_account = $database_config['user_acc']['table'];
		$this->auth->tbl_join_user_account = $database_config['user_acc']['join'];
		$this->auth->tbl_col_user_account = array_merge($database_config['user_acc']['columns'], $database_config['user_acc']['custom_columns']);
		#$this->auth->tbl_custom_col_user_account = $database_config['user_acc']['custom_columns']; // Currently unused.

		// User custom data table(s)
		$this->auth->tbl_custom_data = (! empty($database_config['custom'])) ? $database_config['custom'] : array();
		
		// Database settings
		$this->auth->db_settings = $database_config['settings'];

		// Primary user identity column
		$this->auth->primary_identity_col = $database_config['user_acc']['table'].'.'.$database_config['settings']['primary_identity_col'];
		
		// Security settings
		$this->auth->auth_security = $this->config->item('security','auth');
		
		// General settings
		$this->auth->auth_settings = $this->config->item('settings','auth');
		
		// Email settings
		$this->auth->email_settings = $this->config->item('email','auth');
		
		// Set flexi auth SQL clauses
		$this->auth->select = $this->auth->join = $this->auth->order_by = $this->auth->group_by = $this->auth->limit = array();
		$this->auth->where = $this->auth->or_where = $this->auth->where_in = array();
		$this->auth->or_where_in = $this->auth->where_not_in = $this->auth->or_where_not_in = array();
		$this->auth->like = $this->auth->or_like = $this->auth->not_like = $this->auth->or_not_like = array();
	}

	public function add_group()
	{
		if( !$this->authorize->is_admin(3) )
			return array( 'error'=>TRUE, 'error_msg'=>'you do not have permission to add groups' );
		
		$error['error'] = TRUE;
		$error['error_msg'] = "could not add group";
		$parent = $this->get_groups( array( 'id'=>$this->input->post('parent') ) );
		$user = $this->get_user_group();
		$node = array( 'id'=>FALSE );
		if( isset($parent['l']) && isset($user['l']) )
		{
			if( $parent['l'] < $user['l'] )
			{
				$this->db->trans_rollback();
				return array( 'error_msg'=>'You cannot create a group to or beyond your group level', 'error'=>TRUE );
			}
			elseif( $parent['l'] > $user['l'] )
			{
				$data = array(
					'name' => $this->input->post('name'),
					'desc' => $this->input->post('description'),
					'parent'=>$parent['id']
				);
				$this->load->library('tree');
				$node = $this->tree->nstNewNextSibling( 'code_groups', $parent, $data );
				if(isset($node['id']))
				{
					$error['error_msg'] = "Group added successfully";
					$error['error'] = FALSE;
				}
			}
		}
		return $error;
	}


	public function update_group()
	{
		if( !$this->authorize->is_admin(3) )
			return array( 'error'=>TRUE, 'error_msg'=>'you do not have permission to edit groups' );
		
		$parent = $this->get_groups( array( 'id'=>$this->input->post('parent') ) );
		$user = $this->get_user_group();
		$current = $this->get_groups( array( 'id'=>$this->input->post('id') ) );
		
		if( isset($parent['l']) && isset($user['l']) && isset($current['l']) )
		{
			if( $parent['l'] < $user['l'] )
			{
				return array( 'error_msg'=>'Update partially completed. You cannot upgrade a group to or beyond your group level', 'error'=>TRUE );
			}
			elseif( $parent['l'] != $current['l'] && $parent['l'] > $user['l'] )
			{
				$this->load->library('tree');
				$this->tree->nstMoveToNextSibling( $this->db->dbprefix('user_groups'), $current, $parent );
				$data = array(
					'name' => $this->input->post('name'),
					'desc' => $this->input->post('description'), 
					'parent'=>$parent['id']
				);
				$this->db->where( 'id', $current['id'] );
				$this->db->update( 'user_groups', $data );
			}
		}
		$error = array( 'error'=>FALSE, 'error_msg' => "Group updated successfully" );	
		return $error;
	}


	private function get_user_group($id=FALSE)
	{
		if(!$id && $this->flexi_auth->is_logged_in())
			$id = $this->flexi_auth->get_user_id();
		if( is_numeric($id) && $id>0 )
		{
			$this->db->from('user_accounts');
			$this->db->select( 'groups.id, groups.l, groups.r, groups.name' );
			$this->db->join( 'user_groups', 'groups.id = user_accounts.uacc_group_fk', 'inner' );
			$this->db->where( 'user_accounts.uacc_id', $id );
			$q = $this->db->get();
			if( $q->num_rows()==1 )
				return $q->row_array();
		}
		return FALSE;
	}


	public function get_groups($args = array())
	{
		if(! isset($args['id']) ) $args['id'] = FALSE;
		if(! isset($args['id !=']) ) $args['id !='] = FALSE;
		if(! isset($args['limit']) ) $args['limit'] = FALSE;
		if(! isset($args['start']) ) $args['start'] = 0;
		if(! isset($args['count']) ) $args['count'] = FALSE;
		
		if( $args['id !='] )
			$this->db->where('id !=', $args['id !='] );
		$grp = $this->get_user_group();
		if(isset($grp['l']))
			$this->db->where( 'l >=', $grp['l'] );
		
		if( $args['limit'] )
		{
			$this->db->limit( $args['limit'], $args['start'] );
		}
		
		if( $args['id'] )
		{
			$this->db->where( 'id', $args['id'] );
			$query = $this->db->get('user_groups');
			if( $query->num_rows()==1 )
			return $query->row_array();
		}
		
		$this->db->order_by('l asc');
		
		$query = $this->db->get('user_groups');
		
		if($args['count'])
			return $query->num_rows();
		
		if( $query->num_rows() > 0 )
			return $query->result_array();
		
		return array();
	}

###++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++###	
	// USER TASK METHODS
###++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++###	
	
	/**
	 * activate_user
	 * Activates a users account allowing them to login to their account. 
	 * If $verify_token = TRUE, a valid $activation_token must also be submitted.
	 *
	 * @return void
	 * @author Rob Hussey
	 * @author Mathew Davies
	 */
	public function activate_user($user_id, $activation_token = FALSE, $verify_token = TRUE, $clear_token = TRUE)
	{
		if ($activation_token)
		{
			// Confirm activation token is 40 characters long (length of sha1).
			if ($verify_token && strlen($activation_token) != 40)
			{
				return FALSE;
			}
			// Verify that $activation_token matches database record.
			else if ($verify_token && strlen($activation_token) == 40)
			{
				$sql_where = array(
					$this->auth->tbl_col_user_account['id'] => $user_id,
					$this->auth->tbl_col_user_account['activation_token'] => $activation_token
				);

				$query = $this->db->where($sql_where)
					->get($this->auth->tbl_user_account);

				if ($query->num_rows() !== 1)
				{
					return FALSE;
				}
			}
		}
		
		if ($clear_token)
		{
			$sql_update[$this->auth->tbl_col_user_account['activation_token']] = '';
		}
		$sql_update[$this->auth->tbl_col_user_account['active']] = 1;

		$this->db->update($this->auth->tbl_user_account, $sql_update, array($this->auth->tbl_col_user_account['id'] => $user_id));
							
	    return $this->db->affected_rows() == 1;
	}

	###++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++###

	/**
	 * deactivate_user
	 * Deactivates a users account, preventing them from logging in.
	 *
	 * @return void
	 * @author Rob Hussey
	 * @author Mathew Davies
	 */
	public function deactivate_user($user_id)
	{
	    if (empty($user_id))
	    {
			return FALSE;
	    }

	    $activation_token = sha1($this->generate_token(20));

	    $sql_update = array(
			$this->auth->tbl_col_user_account['activation_token'] => $activation_token,
			$this->auth->tbl_col_user_account['active'] => 0
	    );

		$this->db->update($this->auth->tbl_user_account, $sql_update, array($this->auth->tbl_col_user_account['id'] => $user_id));

	    return $this->db->affected_rows() == 1;
	}


	public function insert_user( $account, $custom_data )
	{
		if( empty($account['email']) || empty($account['password']) || (empty($account['username']) ) )
		{
			return array( 'error'=>TRUE, 'error_msg'=>'Could not create account due to insufficient data' );
		}
		
		// Check email / username is unique.
		$identity = $this->identity_available($account);
		if( is_array($identity) )
			return $identity;
		
		$ip_address = $this->input->ip_address();
		
		$security = $this->autharray['security'];
		$settings = $this->autharray['settings'];
		$user_acc = $this->autharray['database']['user_acc'];
		
		$store_database_salt = $security['store_database_salt'];
	    $database_salt = $store_database_salt ? $this->generate_token($security['database_salt_length']) : FALSE;
		
		$hash_password = $this->generate_hash_token($account['password'], $database_salt, TRUE);
		$activation_token = sha1($this->generate_token(20));
		$suspend_account = ($settings['suspend_new_accounts']) ? 1 : 0;
		
		// Start SQL transaction.
		$this->db->trans_start();
		
		// Main user account table.	
	    $sql_insert = array(
			$user_acc['columns']['group_id'] => $settings['default_group_id'],
			$user_acc['columns']['email'] => $account['email'],
			$user_acc['columns']['username'] => ($account['username']) ? $account['username'] : '',
			$user_acc['columns']['password'] => $hash_password,
			$user_acc['columns']['ip_address'] => $ip_address,
			$user_acc['columns']['last_login_date'] => $this->database_date_time(),
			$user_acc['columns']['date_added'] => $this->database_date_time(),
			$user_acc['columns']['activation_token'] => $activation_token,
			$user_acc['columns']['active'] => 0,		
			$user_acc['columns']['suspend'] => $suspend_account		
		);

	    if ($store_database_salt)
	    {
			$sql_insert[$user_acc['columns']['salt']] = $database_salt;
	    }

		// Loop through custom data columns for the main user table set via config file.
		foreach($this->autharray['database']['user_acc']['custom_columns'] as $column)
		{			
			if (array_key_exists($column, $custom_data))
			{
				$sql_insert[$column] = $custom_data[$column];
				unset($custom_data[$column]);
			}
		}

	    // Create main user account.
		$this->db->insert($user_acc['table'], $sql_insert);
		
		###+++++++++++++++++++++++++++++++++###

		// Custom user data table(s).
		// Get newly created User Account id for join with custom user data table(s).
	    $user_id = $this->db->insert_id();
		
		$this->insert_custom_user_data($user_id, $custom_data);
		
		###+++++++++++++++++++++++++++++++++###

		// Complete SQL transaction.
		$this->db->trans_complete();

	    return is_numeric($user_id) ? $user_id : array('error'=>TRUE, 
	    	'error_msg'=>'Could not create account. Please check your data and try again');
	}

	###++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++###	
	
	/**
	 * insert_custom_user_data
	 * Inserts data into a custom user table and returns the table name and row id of each record inserted.
	 *
	 * @return array/bool
	 * @author Rob Hussey
	 */
	/**
	 * insert_custom_user_data
	 * Inserts data into a custom user table and returns the table name and row id of each record inserted.
	 *
	 * @return array/bool
	 * @author Rob Hussey
	 */
	public function insert_custom_user_data($user_id = FALSE, $custom_data = FALSE)
	{
		if (! is_numeric($user_id) || ! is_array($custom_data) || empty($this->auth->database_config['custom']))
		{
			return FALSE;
		}
	
		// Set a var to return the name and id of each table and row that is inserted to the database.
		$row_data = array();

		// Loop through custom data table(s) set via config file.
		foreach ($this->auth->database_config['custom'] as $custom_table => $table_data)
		{
			$sql_insert = array();
			
			// Loop through custom user data table and try to match columns with $custom_data values.
			if (! empty($table_data['custom_columns']))
			{
				foreach ($table_data['custom_columns'] as $key => $column)
				{
					if (is_array($custom_data) && isset($custom_data[$column]))
					{
						$sql_insert[$this->auth->tbl_custom_data[$custom_table]['custom_columns'][$key]] = $custom_data[$column];
					}
					else if($this->input->post($column))
					{
						$sql_insert[$this->auth->tbl_custom_data[$custom_table]['custom_columns'][$key]] = $this->input->post($column);
					}
				}
			}
			
			if (count($sql_insert) > 0)
			{
				$sql_insert[$table_data['join']] = $user_id;

				$this->db->insert($table_data['table'], $sql_insert);
				
				// Get new table row id.
				if ($this->db->affected_rows() > 0) 
				{
					$row_data[$table_data['table']] = $this->db->insert_id();
				}
			}
		}
		
		return (! empty($row_data)) ? $row_data : FALSE;
	}

	###++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++###

	public function identity_available($args=array())
	{
		if(!isset($args['username'])) $args['username'] = FALSE;
		if(!isset($args['email'])) $args['email'] = FALSE;
		$user_acc = $this->autharray['database']['user_acc'];
		
		if($args['username'] && $args['email'])
		{
			$this->db->where( $user_acc['columns']['username'], $args['username'] );
			$this->db->or_where( $user_acc['columns']['email'], $args['email'] );
		}
		elseif( $args['username'] )
			$this->db->where( $user_acc['columns']['username'], $args['username'] );
		elseif( $args['email'] )
			$this->db->where( $user_acc['columns']['email'], $args['email'] );
		else return array( 'error'=>TRUE, 'error_msg'=>'Either email / username is required' );
		
		$this->db->select( "{$user_acc['columns']['username']}, {$user_acc['columns']['email']}" );
		
		$q = $this->db->get( $user_acc['table'] );
		
		if($q->num_rows()>0)
		{
			$data = $q->row_array();
			if( $args['username'] && $data[$user_acc['columns']['username']] == $args['username'] )
				return array( 'error'=>TRUE, 'error_msg'=>'Username has already been taken by someone else' );
			elseif( $args['email'] && $data[$user_acc['columns']['email']] == $args['email'] )
				return array( 'error'=>TRUE, 'error_msg'=>'Your email has already been registered in the system' );
			else
				return array( 'error'=>TRUE, 'error_msg'=>'It seems either your email / username already exist in our system.' );
		}
		return FALSE;
	}


	###++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++###	
	// GET USER METHOD
	###++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++###	
	
	/**
	 * get_users
	 * Allows strings or arrays to pass SQL SELECT, WHERE and GROUP BY statements. Defaults to return all.
	 *
	 * @return object
	 * @author Rob Hussey
	 */
	public function get_users($sql_select = FALSE, $sql_where = FALSE, $sql_group_by = TRUE)
	{
		if(!isset($args['where'])) $args['where'] = FALSE;
		if(!isset($args['select'])) $args['select'] = FALSE;
		if(!isset($args['group_by'])) $args['group_by'] = FALSE;
		if(!isset($args['count'])) $args['count'] = FALSE;
	    // Left Join user group table to user account table.
	    $this->db->join(
			$this->auth->tbl_user_group, 
			$this->auth->tbl_col_user_account['group_id'].' = '.$this->auth->tbl_join_user_group, 'left'
		);

		// Left Join user custom data table(s) to user account table.
		foreach ($this->auth->tbl_custom_data as $table)
		{
			$this->db->join($table['table'], $this->auth->tbl_join_user_account.' = '.$table['join'], 'left');
		}

		// Group by users id to prevent multiple custom data rows to be listed per user.
		if ($args['group_by'] === TRUE)
		{
			$this->db->group_by($this->auth->tbl_col_user_account['id']);
		}
		// Else, if a specific column is defined, group by that column.
		else if ($args['group_by'])
		{
			$this->db->group_by($args['group_by']);
		}
		// Set any custom defined SQL statements.
		$this->set_custom_sql_to_db($args['select'], $args['where']);
		return $this->db->get($this->auth->tbl_user_account);
	}





	/**
	 * set_custom_sql_to_db
	 * Used internally by flexi auth to call any custom user defined SQL Active Record functions at the correct point during a function.
	 *
	 * @return null
	 * @author Rob Hussey
	 */
	public function set_custom_sql_to_db($sql_select = FALSE, $sql_where = FALSE) 
	{
		// Set directly submitted SELECT and WHERE clauses.
		if (!empty($sql_select))
		{
			$this->db->select($sql_select);
		}

		if (!empty($sql_where))
		{
			$this->db->where($sql_where);
		}
	
		### ++++++++++++++++++++ ###
	
		// Set SQL clauses defined via flexi auth SQL Active Record functions.

		// Set array of all SQL clause types.
		$clause_types = array(
			'select', 'where', 'or_where', 'where_in', 'or_where_in', 'where_not_in', 'or_where_not_in', 
			'like', 'or_like', 'not_like', 'or_not_like', 'join', 'order_by', 'group_by', 'limit'
		);
		
		// Loop through clause types.
		foreach($clause_types as $sql_clause)
		{
			// If a clause is set.
			if (! empty($this->auth->$sql_clause))
			{
				// Loop through the clause array setting values using active record.
				foreach($this->auth->$sql_clause as $value)
				{
					// Key, value and parameter method.
					if (is_array($value) && key($value) === 'key_value_param_method') 
					{
						$data = current($value);					
						$this->db->$sql_clause($data['key'], $data['value'], $data['param']);
					}
					// Key and value method.
					else if (is_array($value) && key($value) === 'key_value_method') 
					{
						$data = current($value);
						$this->db->$sql_clause($data['key'], $data['value']);
					}
					// String or Associative array method.
					else 
					{
						$this->db->$sql_clause($value);
					}
				}
			}
		}
	}

	###++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++###
	
	/**
	 * clear_arg_sql
	 * Clears any custom user defined SQL Active Record functions.
	 *
	 * @return null
	 * @author Rob Hussey
	 */
	public function clear_arg_sql() 
	{
		$this->auth->select = $this->auth->join = $this->auth->order_by = $this->auth->group_by = $this->auth->limit = array();
		$this->auth->where = $this->auth->or_where = $this->auth->where_in = array();
		$this->auth->or_where_in = $this->auth->where_not_in = $this->auth->or_where_not_in = array();
		$this->auth->like = $this->auth->or_like = $this->auth->not_like = $this->auth->or_not_like = array();
	}







###++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++###	
	// TOKEN GENERATION
###++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++###	
	
	/**
	 * generate_token
	 * Generates a random unhashed password / token / salt.
	 * Includes a safe guard to ensure vowels are removed to avoid offensive words when used for password generation.
	 * Additionally, 0, 1 removed to avoid confusion with o, i, l.
	 *
	 * @return string
	 */
	public function generate_token($length = 8) 
	{
		$characters = '23456789BbCcDdFfGgHhJjKkMmNnPpQqRrSsTtVvWwXxYyZz';
		$count = mb_strlen($characters);

		for ($i = 0, $token = ''; $i < $length; $i++) 
		{
			$index = rand(0, $count - 1);
			$token .= mb_substr($characters, $index, 1);
		}
		return $token;
	}

	###++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++###
	/**
	 * generate_hash_token
	 * Generates a new hashed password / token.
	 *
	 * @return string
	 * @author Rob Hussey
	 */
	public function generate_hash_token($token, $database_salt = FALSE, $is_password = FALSE)
	{
	    if (empty($token))
	    {
	    	return FALSE;
	    }
		
		// Get static salt if set via config file.
		$security = $this->autharray['security'];
		$static_salt = $security['static_salt'];
		
		if ($is_password)
		{
			require_once(SHAREDPATH.'libraries/phpass/PasswordHash.php');				
			$phpass = new PasswordHash(8, FALSE);
			
			return $phpass->HashPassword($database_salt . $token . $static_salt);
		}
		else
		{
			return sha1($database_salt . $token . $static_salt);
		}
	}

	###++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++###	
	
	/**
	 * verify_password
	 * Verify that a submitted password matches a user database record.
	 *
	 * @return bool
	 * @author Rob Hussey
	 */
	public function verify_password($identity, $verify_password)
	{
		if (empty($identity) || empty($verify_password))
		{
			return FALSE;
		}
				
		$sql_select = array(
			$this->auth->tbl_col_user_account['password'],
			$this->auth->tbl_col_user_account['salt']
		);
		
		$query = $this->db->select($sql_select)
			->where($this->auth->primary_identity_col, $identity)
			->limit(1)
			->get($this->auth->tbl_user_account);
				 
	    $result = $query->row();

	    if ($query->num_rows() !== 1)
	    {
			return FALSE;
	    }
				
		$database_password = $result->{$this->auth->database_config['user_acc']['columns']['password']};
		$database_salt = $result->{$this->auth->database_config['user_acc']['columns']['salt']};
		$static_salt = $this->auth->auth_security['static_salt'];
		
		require_once(SHAREDPATH.'libraries/phpass/PasswordHash.php');				
		$hash_token = new PasswordHash(8, FALSE);
					
		return $hash_token->CheckPassword($database_salt . $verify_password . $static_salt, $database_password);
	}

	/**
	 * validate_activation_time_limit 
	 * Validate whether a non-activatated account is within the activation time limit set via config.
	 *
	 * @return bool
	 * @author Rob Hussey
	 */
	private function validate_activation_time_limit($last_login)
	{
		if (empty($last_login))
		{
			return FALSE;
		}
	
		// Set account activation expiry time.
		$expire_time = (60 * $this->auth->auth_settings['account_activation_time_limit']); // 60 Secs * expire minutes.		
		
		// Convert if using MySQL time.
		if (strtotime($last_login)) 
		{
			$last_login = strtotime($last_login);
		}
		
		// Account activation time has expired, user must now activate account via email.
		if (($last_login + $expire_time) < time())
		{
			return FALSE;
		}
		
		return TRUE;
	}

	/**
	 * ip_login_attempts_exceeded
	 * Validates whether the number of failed login attempts from a unique IP address has exceeded a defined limit.
	 * The function can be used in conjunction with showing a Captcha for users repeatedly failing login attempts.
	 *
	 * @return bool
	 * @author Rob Hussey
	 */
	public function ip_login_attempts_exceeded()
	{
		// Compare users IP address against any failed login IP addresses.
		$sql_where = array(
			$this->auth->tbl_col_user_account['failed_login_ip'] => $this->input->ip_address(),
			$this->auth->tbl_col_user_account['failed_logins'].' >= ' => $this->auth->auth_security['login_attempt_limit']
		);	
	
	    $query = $this->db->where($sql_where)
			->get($this->auth->tbl_user_account);
		
		return $query->num_rows() > 0;
	}

	/**
	 * login_attempts_exceeded 
	 * Check whether user has made too many failed login attempts within a set time limit.
	 *
	 * @return bool
	 * @author Rob Hussey
	 */
	private function login_attempts_exceeded($identity)
	{
		if (empty($identity))
		{
			return TRUE;
		}

		$sql_select = array(
			$this->auth->tbl_col_user_account['failed_logins'], 
			$this->auth->tbl_col_user_account['failed_login_ban_date']
		);
		
	    $query = $this->db->select($sql_select)
			->where($this->auth->primary_identity_col, $identity)
			->get($this->auth->tbl_user_account);

		if ($query->num_rows() == 1)
		{
			$user = $query->row();
			
			$attempts = $user->{$this->auth->database_config['user_acc']['columns']['failed_logins']};
			$failed_login_date = $user->{$this->auth->database_config['user_acc']['columns']['failed_login_ban_date']};
			
			// Check if login attempts are acceptable.
			if ($attempts < $this->auth->auth_security['login_attempt_limit'])
			{
				return FALSE;
			}
			// Login attempts exceed limit, now check if user has waited beyond time ban limit to attempt another login.
			else if ($this->database_date_time($this->auth->auth_security['login_attempt_time_ban'], $failed_login_date, TRUE) 
				< $this->database_date_time(FALSE, FALSE, TRUE))
			{
				return FALSE;
			}
		}
		
		return TRUE;
	}
	
	/**
	 * increment_login_attempts
	 * This function is called to log details of when a user has failed a login attempt.
	 *
	 * @return bool
	 * @author Rob Hussey
	 */
	private function increment_login_attempts($identity, $attempts)
	{
		if (empty($identity) || !is_numeric($attempts))
		{
			return FALSE;
		}
		
		$attempts++;
		$time_ban = 0;
		
		// Length of time ban in seconds.
		if ($attempts >= $this->auth->auth_security['login_attempt_limit'])
		{
			// Set time ban message.
			$this->set_error_message('login_attempts_exceeded', 'config');
			
			$time_ban = $this->auth->auth_security['login_attempt_time_ban'];
		
			// If failed attempts continue for more than 3 times the limit, increase the time ban by a factor of 2.
			if ($attempts >= ($this->auth->auth_security['login_attempt_limit'] * 3))
			{
				$time_ban = ($time_ban * 2);
			}

			// Set time ban as a date.
			$time_ban = $this->database_date_time($time_ban);
		}
		
		// Record users ip address to compare future login attempts.
		$login_data = array(
			$this->auth->tbl_col_user_account['failed_login_ip'] => $this->input->ip_address(),
			$this->auth->tbl_col_user_account['failed_logins'] => $attempts,
			$this->auth->tbl_col_user_account['failed_login_ban_date'] => $time_ban
		);
		
		$this->db->update($this->auth->tbl_user_account, $login_data, array($this->auth->primary_identity_col => $identity));
		
	    return $this->db->affected_rows() == 1;
	}

	/**
	 * reset_login_attempts 
	 * This function is called when a user successfully logs in, it's used to remove any previously logged failed login attempts.
	 * This prevents a user accumulating a login time ban for every failed attempt they make.
	 *
	 * @return bool
	 * @author Rob Hussey
	 */
	private function reset_login_attempts($identity)
	{
		if (empty($identity))
		{
			return FALSE;
		}
		
		$login_data = array(
			$this->auth->tbl_col_user_account['failed_login_ip'] => '',
			$this->auth->tbl_col_user_account['failed_logins'] => 0,
			$this->auth->tbl_col_user_account['failed_login_ban_date'] => 0
		);
		
		$this->db->update($this->auth->tbl_user_account, $login_data, array($this->auth->primary_identity_col => $identity));
				
	    return $this->db->affected_rows() == 1;
	}

	/**
	 * recaptcha
	 * Generates the html for Google reCAPTCHA.
	 * Note: If the reCAPTCHA is located on an SSL secured page (https), set $ssl = TRUE.
	 *
	 * @return string
	 * @author Rob Hussey
	 */
	public function recaptcha($ssl = FALSE)
	{
		$this->load->helper('recaptcha');

		// Get config settings.
		$captcha_theme = $this->auth->auth_security['recaptcha_theme'];
		$captcha_lang = $this->auth->auth_security['recaptcha_language'];
		
		// Set defaults.
		$theme = "theme:'clean',";
		$language = "lang:'en'";
		
		// Set reCAPTCHA theme.
		if (!empty($captcha_theme))
		{
			if ($captcha_theme == 'custom')
			{
				$theme = "theme:'custom', custom_theme_widget:'recaptcha_widget,'";
			}
			else
			{
				$theme = "theme:'".$captcha_theme."',";
			}
		}
		
		// Set reCAPTCHA language.
		if (!empty($captcha_lang))
		{
			$language = "lang:'".$captcha_lang."'";
		}
		
		$theme_html = "<script>var RecaptchaOptions = { $theme $language };</script>\n";
		$captcha_html = recaptcha_get_html($this->auth->auth_security['recaptcha_public_key'], NULL, $ssl);

		return $theme_html.$captcha_html;
	}
	
	/**
	 * validate_recaptcha
	 * Validates if a Google reCAPTCHA answer submitted via http POST data is correct.
	 *
	 * @return bool
	 * @author Rob Hussey
	 */
	public function validate_recaptcha()
	{
		$this->load->helper('recaptcha');

		$response = recaptcha_check_answer(
			$this->auth->auth_security['recaptcha_private_key'],
			$this->input->ip_address(),
			$this->input->post('recaptcha_challenge_field'),
			$this->input->post('recaptcha_response_field')
		);

		return $response->is_valid;
	}
	
	/**
	 * math_captcha
	 * Basic captcha reliant on maths questions rather than text images.
	 *
	 * @return array
	 * @author Rob Hussey
	 */
	public function math_captcha()
	{
		$min_operand_val = 1;
		$max_operand_val = 20;
		$total_operands = 2;
		$operators = array('+'=>' + ', '-'=>' - ');
		$equation = '';
		
        for ($i = 1; $total_operands >= $i; $i++) 
		{
			$operand = rand($min_operand_val, $max_operand_val);
			$operator = ($i < $total_operands) ? array_rand($operators) : '';			
			$equation .= $operand.$operator;
		}

		// Convert equation symbols to written symbols.
		$captcha['equation'] = str_replace(array_keys($operators), array_values($operators), $equation);
		
		// Convert equation string.
		eval("\$captcha['answer'] = ".$equation.";");
	
		return $captcha;
	}


	/**
	 * get_primary_identity
	 * Looks-up database identity columns and return users primary identifier.
	 *
	 * @return string
	 * @author Rob Hussey
	 */
	public function get_primary_identity($identity)
	{
		if (empty($identity) || !is_string($identity))
		{
			return FALSE;
		}
			
		$identity_cols = $this->auth->db_settings['identity_cols'];

		// Loop through database identity columns.
		for ($i = 0; count($identity_cols) > $i; $i++) 
		{
			$this->db->or_where($identity_cols[$i], $identity);
		}
		
		$query = $this->db->select($this->auth->primary_identity_col)
			->get($this->auth->tbl_user_account);
		
		// Return users primary identity.
		if ($query->num_rows() == 1)
		{
			return $query->row()->{$this->auth->db_settings['primary_identity_col']};
		}
		return FALSE;
	}

###++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++###	
	// LOGIN / VALIDATION METHODS
###++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++###	
	
	/**
	 * login
	 * Verifies a users identity and password, if valid, they are logged in.
	 *
	 * @return bool
	 * @author Rob Hussey
	 */
	public function login($identity = FALSE, $password = FALSE, $remember_user = FALSE)
	{	
		if (empty($identity) || empty($password) || (!$identity = $this->get_primary_identity($identity)))
	    {
			return array( 'error'=>TRUE, 'error_msg'=>'Either Username or Email are required to login.' );
	    }
		
		// Check if login attempts are being counted.
		if ($this->auth->auth_security['login_attempt_limit'] > 0)
		{
			// Check user has not exceeded login attempts.
			if ($this->login_attempts_exceeded($identity))
			{
				//$this->set_error_message('login_attempts_exceeded', 'config');
				return array( 'error'=>TRUE, 
					'error_msg'=>lang('login_attempts_exceeded') );
			}
		}
		
		$sql_select = array(
			$this->auth->primary_identity_col, 
			$this->auth->tbl_col_user_account['id'], 
			$this->auth->tbl_col_user_account['password'], 
			$this->auth->tbl_col_user_account['group_id'], 
			$this->auth->tbl_col_user_account['activation_token'], 
			$this->auth->tbl_col_user_account['active'], 
			$this->auth->tbl_col_user_account['suspend'], 
			$this->auth->tbl_col_user_account['last_login_date'], 
			$this->auth->tbl_col_user_account['failed_logins']
		);
		
		$sql_where = array($this->auth->primary_identity_col => $identity);
		
		// Set any custom defined SQL statements.
		$this->set_custom_sql_to_db();

		$query = $this->db->select($sql_select)
			->where($sql_where)
			->get($this->auth->tbl_user_account);
		
		###+++++++++++++++++++++++++++++++++###
		
	    // User exists, now validate credentials.
		if ($query->num_rows() == 1)
	    {	
			$user = $query->row();
			
			// If an activation time limit is defined by config file and account hasn't been activated by email.
			if ($this->auth->auth_settings['account_activation_time_limit'] > 0 && 
				!empty($user->{$this->auth->database_config['user_acc']['columns']['activation_token']}))
			{
				if (!$this->validate_activation_time_limit($user->{$this->auth->database_config['user_acc']['columns']['last_login_date']}))
				{
					//$this->set_error_message('account_requires_activation', 'config');
					return array( 'error'=>TRUE, 
						'error_msg'=>lang('account_requires_activation') );
				}
			}

			// Check whether account has been activated.
			if ($user->{$this->auth->database_config['user_acc']['columns']['active']} == 0)
			{
				//$this->set_error_message('account_requires_activation', 'config');
				return array( 'error'=>TRUE, 
					'error_msg'=>lang('account_requires_activation') );
			}
			
			// Check if account has been suspended.
			if ($user->{$this->auth->database_config['user_acc']['columns']['suspend']} == 1)
			{
				//$this->set_error_message('account_suspended', 'config');
				return array( 'error'=>TRUE, 
					'error_msg'=>lang('account_suspended') );
			}
			
			// Verify submitted password matches database.
			if ($this->verify_password($identity, $password))
			{
				// Reset failed login attempts.
				if ($user->{$this->auth->database_config['user_acc']['columns']['failed_logins']} > 0)
				{
					$this->reset_login_attempts($identity);
				}
				
				// Set user login sessions.
				if ($this->set_login_sessions($user, TRUE))
				{
					// Set 'Remember me' cookie and database record if checked by user.
					if ($remember_user)
					{
						$this->remember_user($user->{$this->auth->database_config['user_acc']['columns']['id']});
					}
					// Else, ensure any existing 'Remember me' cookies are deleted.
					// This can occur if the user logs in via password, whilst already logged in via a "Remember me" cookie. 
					else
					{
						$this->flexi_auth_lite_model->delete_remember_me_cookies();
					}
					return TRUE;
				}
			}
			// Password does not match, log the failed login attempt if defined via the config file.
			else if ($this->auth->auth_security['login_attempt_limit'] > 0)
			{				
				$attempts = $user->{$this->auth->database_config['user_acc']['columns']['failed_logins']};

				// Increment failed login attempts.
				$this->increment_login_attempts($identity, $attempts);
			}
	    }
		
	    return FALSE;
	}
	
	/**
	 * login_remembered_user
	 *
	 * @return bool
	 * @author Rob Hussey
	 * @author Ben Edmunds
	 */
	public function login_remembered_user()
	{
	    if (!get_cookie($this->auth->cookie_name['user_id']) || !get_cookie($this->auth->cookie_name['remember_series']) || 
			!get_cookie($this->auth->cookie_name['remember_token']))
	    {
		    return FALSE;
	    }

		$user_id = get_cookie($this->auth->cookie_name['user_id']);
		$remember_series = get_cookie($this->auth->cookie_name['remember_series']);
		$remember_token = get_cookie($this->auth->cookie_name['remember_token']);
		
		$sql_select = array(
			$this->auth->primary_identity_col,
			$this->auth->tbl_col_user_account['id'], 
			$this->auth->tbl_col_user_account['group_id'], 
			$this->auth->tbl_col_user_account['activation_token'], 
			$this->auth->tbl_col_user_account['last_login_date']
		);

		// Database session tokens are hashed with user-agent to 'help' invalidate hijacked cookies used from different browser.
		$sql_where = array(
			$this->auth->tbl_col_user_account['id'] => $user_id,
			$this->auth->tbl_col_user_account['active'] => 1,
			$this->auth->tbl_col_user_account['suspend'] => 0,
			$this->auth->tbl_col_user_session['series'] => $this->hash_cookie_token($remember_series),
			$this->auth->tbl_col_user_session['token'] => $this->hash_cookie_token($remember_token),
			$this->auth->tbl_col_user_session['date'].' > ' => $this->database_date_time(-$this->auth->auth_security['user_cookie_expire'])
		);

		$query = $this->db->select($sql_select)
			->from($this->auth->tbl_user_account)
			->join($this->auth->tbl_user_session, $this->auth->tbl_join_user_account.' = '.$this->auth->tbl_join_user_session)
			->where($sql_where)
			->get();
			
		###+++++++++++++++++++++++++++++++++###

	    // If user exists.
	    if ($query->num_rows() == 1)
	    {
			$user = $query->row();
		
			// If an activation time limit is defined by config file and account hasn't been activated by email.
			if ($this->auth->auth_settings['account_activation_time_limit'] > 0 && 
				!empty($user->{$this->auth->database_config['user_acc']['columns']['activation_token']}))
			{
				if (!$this->validate_activation_time_limit($user->{$this->auth->database_config['user_acc']['columns']['last_login_date']}))
				{
					$this->set_error_message('account_requires_activation', 'config');
					return FALSE;
				}
			}

			// Set user login sessions.
			if ($this->set_login_sessions($user))
			{
				// Extend 'Remember me' if defined by config file.
				if ($this->auth->auth_security['extend_cookies_on_login'])
				{
					$this->remember_user($user->{$this->auth->database_config['user_acc']['columns']['id']});
				}
				return TRUE;
			}
	    }
		
		// 'Remember me' has been unsuccessful, for security, remove any existing cookies and database sessions.
		$this->delete_database_login_session($user_id);

	    return FALSE;
	}

	/**
	 * update_last_login
	 * Updates the main user account table with the last time a user logged in and their IP address. 
	 * The data type of the date can be formatted via the config file.
	 *
	 * @return bool
	 * @author Rob Hussey
	 * @author Ben Edmunds
	 */
	public function update_last_login($user_id)
	{
		// Update user IP address and last login date.
		$login_data = array(
			$this->auth->tbl_col_user_account['ip_address'] => $this->input->ip_address(),
			$this->auth->tbl_col_user_account['last_login_date'] => $this->database_date_time()
		);
		
		$this->db->update($this->auth->tbl_user_account, $login_data, array($this->auth->tbl_col_user_account['id'] => $user_id));

	    return $this->db->affected_rows() == 1;
	}
	
	/**
	 * set_login_sessions
	 * Set all login session and database data.
	 *
	 * @return bool
	 * @author Rob Hussey / Filou Tschiemer
	 */
	private function set_login_sessions($user, $logged_in_via_password = FALSE)
	{
		if (!$user)
		{
			return FALSE;
		}
		
		$user_id = $user->{$this->auth->database_config['user_acc']['columns']['id']};
		
		// Regenerate CI session_id on successful login.
		$this->regenerate_ci_session_id();
		
		// Update users last login date.
		$this->update_last_login($user_id);
		
		// Set database and login session token if defined by config file.
		if ($this->auth->auth_security['validate_login_onload'] && ! $this->insert_database_login_session($user_id))
		{
			return FALSE;
		}
		
		// Set verified login session if user logged in via Password rather than 'Remember me'.
		$this->auth->session_data[$this->auth->session_name['logged_in_via_password']] = $logged_in_via_password;
		
		// Set user id and identifier data to session.
		$this->auth->session_data[$this->auth->session_name['user_id']] = $user_id;
		$this->auth->session_data[$this->auth->session_name['user_identifier']] = $user->{$this->auth->db_settings['primary_identity_col']};

		// Get group data.
		$sql_where[$this->auth->tbl_col_user_group['id']] = $user->{$this->auth->database_config['user_acc']['columns']['group_id']};
		
		$group = $this->get_groups(FALSE, $sql_where)->row();
		
		// Set admin status to session.
		$this->auth->session_data[$this->auth->session_name['is_admin']] = ($group->{$this->auth->database_config['user_group']['columns']['admin']} == 1);
		
		$this->auth->session_data[$this->auth->session_name['group']] = 
			array($group->{$this->auth->database_config['user_group']['columns']['id']} => $group->{$this->auth->database_config['user_group']['columns']['name']});
		
		###+++++++++++++++++++++++++++++++++###

		$privilege_sources = $this->auth->auth_settings['privilege_sources'];
		$privileges = array();

		// If 'user' privileges have been defined within the config 'privilege_sources'.
        if (in_array('user', $privilege_sources))
        {
            // Get user privileges.
            $sql_select = array(
                $this->auth->tbl_col_user_privilege['id'],
                $this->auth->tbl_col_user_privilege['name']
            );

            $sql_where = array($this->auth->tbl_col_user_privilege_users['user_id'] => $user_id);

            $query = $this->get_user_privileges($sql_select, $sql_where);

            // Create an array of user privileges.
            if ($query->num_rows() > 0)
            {
                foreach($query->result_array() as $data)
                {
                    $privileges[$data[$this->auth->database_config['user_privileges']['columns']['id']]] = $data[$this->auth->database_config['user_privileges']['columns']['name']];
                }
            }
        }
        
		// If 'group' privileges have been defined within the config 'privilege_sources'.
        if (in_array('group', $privilege_sources))
        {
            // Get group privileges.
            $sql_select = array(
                $this->auth->tbl_col_user_privilege['id'],
                $this->auth->tbl_col_user_privilege['name']
            );

            $sql_where = array($this->auth->tbl_col_user_privilege_groups['group_id'] => $user->{$this->auth->database_config['user_acc']['columns']['group_id']});

            $query = $this->get_user_group_privileges($sql_select, $sql_where);

            // Extend array of user privileges by group privileges.
            if ($query->num_rows() > 0)
            {
                foreach($query->result_array() as $data)
                {
                    $privileges[$data[$this->auth->database_config['user_privileges']['columns']['id']]] = $data[$this->auth->database_config['user_privileges']['columns']['name']];
                }
            }
        }

		// Set user privileges to session.
		$this->auth->session_data[$this->auth->session_name['privileges']] = $privileges;
		
		###+++++++++++++++++++++++++++++++++###
				
		$this->session->set_userdata(array($this->auth->session_name['name'] => $this->auth->session_data));

		return TRUE;
	}	
	
	/**
	 * update_session_identifier
	 * Updates a users current session identifier if they update the database record of their identity (i.e. Change their email).
	 *
	 * @return bool
	 * @author Rob Hussey
	 */
	public function update_session_identifier($user_id, $identity)
	{
		if ($user_id == $this->auth->session_data[$this->auth->session_name['user_id']])
		{
			$this->auth->session_data[$this->auth->session_name['user_identifier']] = $identity;
			$this->session->set_userdata(array($this->auth->session_name['name'] => $this->auth->session_data));
			
			return TRUE;
		}
		return FALSE;
	}
	
	/**
	 * insert_database_login_session
	 * Used in conjunction with $config['validate_login_onload'] set via the config file.
	 * The function inserts a login session token into the database and browser session. 
	 * These two tokens are then compared on every page load to ensure the users session is still valid.
	 *
	 * This method offers more control over login security as you can logout users immediately (By removing their database session or
	 * suspending / deactivating them), rather than having to wait for the users CodeIgniter session to expire.
	 * However, it requires more database calls per page load.
	 *
	 * @return bool
	 * @author Rob Hussey
	 */
	private function insert_database_login_session($user_id)
	{
	    if (!is_numeric($user_id))
	    {
			return FALSE;
	    }
		
		// Generate session token.
		$session_token = sha1($this->generate_token(20));
		
		$sql_insert = array(
			$this->auth->tbl_col_user_session['user_id'] => $user_id,
			$this->auth->tbl_col_user_session['token'] => $session_token,
			$this->auth->tbl_col_user_session['date'] => $this->database_date_time()
		);

		$this->db->insert($this->auth->tbl_user_session, $sql_insert);
		
	    if ($this->db->affected_rows() > 0)
	    {
			// Create session.
			$this->auth->session_data[$this->auth->session_name['login_session_token']] = $session_token;
			$this->session->set_userdata(array($this->auth->session_name['name'] => $this->auth->session_data));

			// Hash database session token as it will be visible via cookie.
			$hash_session_token = $this->hash_cookie_token($session_token);
							
			// Create cookies to detect if user closes their browser (Defined by config file).
			if ($this->auth->auth_security['logout_user_onclose'])
			{
				set_cookie(array(
					'name' => $this->auth->cookie_name['login_session_token'],
					'value' => $hash_session_token,
					'expire' => 0 // Set to 0 so it expires on browser close.
				));
			}
			// Create a cookie to detect when a user has closed their browser since logging in via password (Defined by config file).
			// If the cookie is not set/valid, a users 'logged in via password' status will be unset.
			else if ($this->auth->auth_security['unset_password_status_onclose'])
			{
				set_cookie(array(
					'name' => $this->auth->cookie_name['login_via_password_token'],
					'value' => $hash_session_token,
					'expire' => 0 // Set to 0 so it expires on browser close.
				));
			}
			
			return TRUE;
		}
		return FALSE;
	}
	
	/**
	 * remember_user
	 * Creates a set of 'Remember me' cookies and inserts a database row containing the cookie session data.
	 *
	 * @return bool
	 * @author Rob Hussey
	 * @author Ben Edmunds
	 */
	private function remember_user($user_id)
	{
	    if (!is_numeric($user_id))
	    {
			return FALSE;
	    }

		// Use existing 'Remember me' series token if it exists.
	    if (get_cookie($this->auth->cookie_name['remember_series']))
		{
			$remember_series = get_cookie($this->auth->cookie_name['remember_series']);
		}
		else
		{
			$remember_series = $this->generate_token(40);
		}
		
	    // Set new 'Remember me' unique token.
		$remember_token = $this->generate_token(40);
		
		// Hash the database session tokens with user-agent to help invalidate hijacked cookies used from different browser.
		$sql_insert = array(
			$this->auth->tbl_col_user_session['user_id'] => $user_id,
			$this->auth->tbl_col_user_session['series'] => $this->hash_cookie_token($remember_series),
			$this->auth->tbl_col_user_session['token'] => $this->hash_cookie_token($remember_token),
			$this->auth->tbl_col_user_session['date'] => $this->database_date_time()
		);

		$this->db->insert($this->auth->tbl_user_session, $sql_insert);
		
		###+++++++++++++++++++++++++++++++++###
		
		// Cleanup and remove the now used 'Remember me' database session if they exist.
		if (get_cookie($this->auth->cookie_name['remember_series']) && get_cookie($this->auth->cookie_name['remember_token']))
		{
			$sql_where = array(
				$this->auth->tbl_col_user_session['user_id'] => $user_id,
				$this->auth->tbl_col_user_session['series'] => 
					$this->hash_cookie_token(get_cookie($this->auth->cookie_name['remember_series'])),
				$this->auth->tbl_col_user_session['token'] => 
					$this->hash_cookie_token(get_cookie($this->auth->cookie_name['remember_token']))
			);

			$this->db->delete($this->auth->tbl_user_session, $sql_where);
		}

		###+++++++++++++++++++++++++++++++++###
		
		// Set new 'Remember me' cookies.
	    if ($this->db->affected_rows() > 0)
	    {
			set_cookie(array(
				'name' => $this->auth->cookie_name['user_id'],
				'value' => $user_id,
				'expire' => $this->auth->auth_security['user_cookie_expire'],
			));

			set_cookie(array(
				'name' => $this->auth->cookie_name['remember_series'],
				'value' => $remember_series,
				'expire' => $this->auth->auth_security['user_cookie_expire'],
			));			

			set_cookie(array(
				'name' => $this->auth->cookie_name['remember_token'],
				'value' => $remember_token,
				'expire' => $this->auth->auth_security['user_cookie_expire'],
			));			
			
			return TRUE;
	    }

		// 'Remember me' has been unsuccessful, for security, remove any existing cookies and database sessions.
		$this->delete_database_login_session($user_id);

	    return FALSE;
	}

	###++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++###	
	// MISC FUNCTIONS
	###++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++###	

	/**
	 * database_date_time
	 * Format the current or a submitted date and time (in seconds). 
	 * Additional time can be added / subtracted.
	 *
	 * @return void
	 * @author Rob Hussey
	 */
	public function database_date_time($apply_time = 0, $time = FALSE, $force_unix = FALSE)
	{
		// Get timestamp of either submitted time or current time.
		if ($time)
		{
			$time = (is_numeric($time) && strlen($time) == 10) ? $time : strtotime($time);
		}
		else
		{
			$time = time();
		}
		
		// Add or subtract any submitted apply time.
		$time += $apply_time;
	
		// If database time is set as UNIX via config file, or if a unix time has been requested.
		if ((is_numeric($this->auth->db_settings['date_time']) && strlen($this->auth->db_settings['date_time']) == 10) || $force_unix)
		{
			return $time; 
		}
		else if (is_string($this->auth->db_settings['date_time']) && strtotime($this->auth->db_settings['date_time'])) // MySQL datetime.
		{
			return date('Y-m-d H:i:s', $time);
		}
		else // Return time set via config file.
		{
			return $this->auth->db_settings['date_time'];
		}
	}

	###++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++###

	/**
	 * set_auth_defaults
	 * Sets the default auth session values
	 *
	 * @return void
	 * @author Rob Hussey
	 */
	public function set_auth_defaults()
	{
		foreach($this->auth->session_name as $session_name => $session_alias)
		{
			if (!in_array($session_name,array('name','math_captcha')))
			{
				$this->auth->session_data[$session_alias] = FALSE;
			}
		}

		$this->session->set_userdata(array($this->auth->session_name['name'] => $this->auth->session_data));
	}

	/**
	 * regenerate_ci_session_id
	 * Regenerate CodeIgniters session id like native PHP session_regenerate_id(TRUE), used whenever a users permissions change.
	 *
	 * @return bool
	 * @author Rob Hussey
	 */
	private function regenerate_ci_session_id()
	{	
		// This is targeting a native CodeIgniter cookie, not a flexi_auth cookie.
		$ci_session = array(
			'name'   => $this->config->item('sess_cookie_name'),
			'value'  => '',
			'expire' => ''
		);
		set_cookie($ci_session);	
	}

	###++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++###
	
	/**
	 * hash_cookie_token
	 * Create a hash of users database session token, users browser details and a static salt.
	 * This can help invalidate hijacked cookies used from a different browser.
	 *
	 * @return bool
	 * @author Rob Hussey
	 */
	public function hash_cookie_token($data)
	{
		if (empty($data))
		{
			return FALSE;
		}
		
		$browser = $this->auth->auth_security['static_salt'].$this->input->server('HTTP_USER_AGENT');
		
		return sha1($data.$browser);
	}



















}?>
