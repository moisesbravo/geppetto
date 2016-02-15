# Class: motd
#
# This module manages the /etc/motd file using a template
#
# @param dynamic_motd [Bool] Enable or disable dynamic motd on Debian systems
# @param template [String] Allows for custom template location
# @param content [String] String to be used for motd, priority given to template
#
# @example
#  include motd
#
class sshpersonalizado (
  $dynamic_motd = true,
  $template = undef,
  $content = undef,
) {

  if $template {
    if $content {
        warning('Both $template and $content parameters passed to motd, ignoring content')
    }
    $motd_content = template($template)
  } elsif $content {
    $motd_content = $content
  } else {
    $motd_content = template('sshpersonalizado/motd.erb')
  }

  if $::kernel == 'Linux' {
    file { '/etc/motd':
      ensure  => file,
      backup  => false,
      content => $motd_content,
    }
   
  } 
}