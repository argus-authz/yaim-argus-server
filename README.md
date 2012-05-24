# YAIM module: ARGUS_server

## Configuration with YAIM

The `ARGUS_server` node type is available to configure the Argus service with YAIM.

Description of all the Argus YAIM Configuration Variables.

### Argus `site-info.def` Configuration

Your `site-info.def` file for Argus must contain at least the following variable:

    # Argus service hostname
    ARGUS_HOST=argus.example.org

    # PAP administrator DN allowed to use 'pap-admin' command
    PAP_ADMIN_DN="/DC=org/DC=acme/CN=John Doe"

    # Users and Groups definition for grid and group mapfile
    USERS_CONF=/opt/glite/yaim/examples/users.conf
    GROUPS_CONF=/opt/glite/yaim/examples/groups.conf

    # Supported VOs
    VOS="dteam"

    VO_DTEAM_VOMSES="'dteam voms.hellasgrid.gr 15004 /C=GR/O=HellasGrid/OU=hellasgrid.gr/CN=voms.hellasgrid.gr dteam' 'dteam voms2.hellasgrid.gr 15004 /C=GR/O=HellasGrid/OU=hellasgrid.gr/CN=voms2.hellasgrid.gr dteam'"
    VO_DTEAM_VOMS_CA_DN="'/C=GR/O=HellasGrid/OU=Certification Authorities/CN=HellasGrid CA 2006' '/C=GR/O=HellasGrid/OU=Certification Authorities/CN=HellasGrid CA 2006'"

## Generate Argus Configuration

Run YAIM to generate the Argus configuration for your site: 

``/opt/glite/yaim/bin/yaim -c -s site-info.def -n ARGUS_server``

At this point, the Argus services (PAP, PDP and PEP Server) must be configured, up and running. 
