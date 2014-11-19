# Define: wkhtmltopdf
# 
# This modules installs wkhtmltopdf to the system
# 
# Parameters:
#   version: version string
#   arch: architecture, 'i386' or 'amd64', defaults to 'amd64'
#   target_dir: the directory to install to, defaults to '/usr/local/bin'
#
# Actions
#   downloads wkhtmltopdf to the desired location
#   renames it to 'wkhtmltopdf'
#
# Example use:
#   wkhtmltopdf { }
#
classs wkhtmltopdf {
  
  $version = '0.12.1'
  $arch = 'amd64'
  $series = 'trusty'
  
  $filename = "wkhtmltox-${version}_linux-${series}-${arch}.deb"
  $source = "http://downloads.sourceforge.net/project/wkhtmltopdf/${filename}"
  $deb_file = "/var/cache/${filename}.deb"
  
  ensure_packages(['wget'])

  exec { "$deb_file":
    command => "wget --timestamping $source --output-document=$deb_file",
    require => [Package['wget'] ],
    path    => '/usr/bin:/bin',
    timeout => 600, # allow maximal 10 minutes for download
    creates => "$deb_file";
  }
  
  package {"wkhtmltopdf":
    ensure => installed,
    source => $deb_file,
    provider => dpkg,
    require  => Exec["$deb_file"],
  }
}
