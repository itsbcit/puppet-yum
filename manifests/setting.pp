# config file settings
define yum::setting(
  $path,
  $section,
  $options,
  $ensure  = 'present',
  $setting = $title,
) {

  $value = $options[$section][$setting]

  ini_setting{"${path}/${section}/${setting} => ${value}":
    ensure  => $ensure,
    path    => $path,
    section => $section,
    setting => $setting,
    value   => $value,
  }
}
