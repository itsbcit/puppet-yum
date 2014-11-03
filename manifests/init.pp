# == Class: yum
#
# Yum configuration management
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { yum:
#  }
#
# === Authors
#
# Author Name <Jesse Weisner@bcit.ca>
#
# === Copyright
#
# Copyright 2014 Jesse Weisner
#

class yum (
  $clean_repos         = false,
  $default_repos_merge = true,
  $default_repos       = { },
  $extra_repos_merge   = true,
  $extra_repos         = { },
  $options_merge       = true,
  $options             = { },
  $plugins_merge       = true,
  $plugins             = { },
){

  # fact shortcuts
  $os_downcase   = downcase($::operatingsystem)
  $os_majrelease = '6'
  $os_short      = "${os_downcase}${os_majrelease}"

  # pull in os defaults
  class{"yum::os::${os_short}": }

  ############
  # begin options processing

  # merge together all default_repos sources
  $default_default_repos = getvar("yum::os::${os_short}::default_repos")
  $default_repos_hiera = str2bool($default_repos_merge)? {
    false   => $default_repos,
    default => hiera_hash('yum::default_repos', {} ),
  }
  $default_repos_real = deep_merge($default_default_repos, $default_repos_hiera)

  # merge together all extra_repos sources
  $default_extra_repos = getvar("yum::os::${os_short}::extra_repos")
  $extra_repos_hiera = str2bool($extra_repos_merge)? {
    false   => $extra_repos,
    default => hiera_hash('yum::extra_repos', {} ),
  }
  $extra_repos_real = deep_merge($default_extra_repos, $extra_repos_hiera)

  # merge together all options sources
  $default_options = getvar("yum::os::${os_short}::options")
  $options_hiera = str2bool($options_merge)? {
    false   => $options,
    default => hiera_hash('yum::options', {} ),
  }
  $options_real = deep_merge($default_options, $options_hiera)

  # merge together all plugins sources
  $default_plugins = getvar("yum::os::${os_short}::plugins")
  $plugins_hiera = str2bool($plugins_merge)? {
    false   => $plugins,
    default => hiera_hash('yum::plugins', {} ),
  }
  $plugins_real = deep_merge($default_plugins, $plugins_hiera)

  # end options processing
  ############

  # main config file overrides
  $main_config_sections = keys($options_real)
  section{$main_config_sections:
    path    => '/etc/yum.conf',
    options => $options_real,
  }
}
