# config file section from hash
define yum::sections(
  $path,
  $options,
  $section = $title,
){

  $setting_keys = keys($options[$section])

  yum::settings{$setting_keys:
    path    => $path,
    options => $options,
    section => $section,
  }
}
