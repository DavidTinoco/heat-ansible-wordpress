# heat-ansible-wordpress

To lauch this you need follow the next steps:
  1. Clone this repository
  ~~~
  git clone https://github.com/DavidTinoco/heat-ansible-wordpress.git
  ~~~
  2. Create and activate a virtualenv
  ~~~
  virtualenv heat-ansible
  source heat-ansible/bin/activate
  ~~~  
  3. Install with pip the following packages
      - python-openstackclient
      - python-heatclient
      - ansible
  ~~~
  pip install ansible python-openstackclient python-heatclient
  ~~~
  4. Login with your script to openstack
  5. Change your proyect parameters on "start.sh" (net and key_name)
  6. Load the private key that you need to login into your openstack instances (ssh-agent)
  7. From repository directory execute
  ~~~
  bash start.sh
  ~~~
  8. Follow the last instructions that the script will tell you
