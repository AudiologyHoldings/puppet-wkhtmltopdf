#puppet-wkhtmltopdf

Puppet module to install wkhtmltopdf

```
git submodule add https://github.com/AudiologyHoldings/puppet-wkhtmltopdf.git modules/wkhtmltopdf
```

##Example usage:

```
class { 'wkhtmltopdf': }
```

##Available options

```
class { 'wkhtmltopdf': 
  'version' => '0.12.1'
  'series' => 'trusty',
  'arch' => 'amd64',
}
```
