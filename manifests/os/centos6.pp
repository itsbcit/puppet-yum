# CentOS 6 defaults
class yum::os::centos6{

  $centos_base_file = '/etc/yum.repos.d/CentOS-Base.repo'
  $centos_debug_file = '/etc/yum.repos.d/CentOS-Debug.repo'
  $default_yum_repos = {
    # CentOS-Base.repo
    'base'       = { 'enabled' => '1', 'path' => $centos_base_file },
    'centosplus' = { 'enabled' => '1', 'path' => $centos_base_file },
    'contrib'    = { 'enabled' => '1', 'path' => $centos_base_file },
    'extras'     = { 'enabled' => '1', 'path' => $centos_base_file },
    'updates'    = { 'enabled' => '1', 'path' => $centos_base_file },

    # CentOS-Debuginfo.repo
    'debug'      = { 'enabled' => '0', 'path' => $centos_debug_file },
  }
}
