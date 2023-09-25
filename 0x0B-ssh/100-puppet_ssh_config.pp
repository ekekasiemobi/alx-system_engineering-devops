#using puppet  set up your client SSH configuration file

include stdlib

file_line {'Turn off passwd auth':
  path    =>  '/etc/ssh/ssh_config',
  line    =>  'PasswordAuthentication no',
  ensure  =>  'present',
  replace =>  true,
}


file_line { 'IdentityFile':
  path    =>  '/etc/ssh/ssh_config',
  line    =>  'IdentityFile ~/.ssh/school',
  ensure  =>  'present',
  replace =>  true,
}
