# CertiPay.Octopus.ReverseProxy

This package is intended as a template for creating a deployable unit containing the script
and configuration needed for an IIS-based reverse proxy. The intent was to be able to push this
to edge servers in the DMZ containing the information needed to proxy requests in to internal
web servers.

## Usage

Need to set the require url manually in the Web.config, but it looks like a good case for using Octopus Deploy variables UI/replacement.