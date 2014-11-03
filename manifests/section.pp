# config file section from hash
define yum::section(
  $path,
  $options,
  $section = $title,
){

  $setting_keys = keys($options[$section])

  yum::setting{$setting_keys:
    path    => $path,
    options => $options,
    section => $section,
  }
}
