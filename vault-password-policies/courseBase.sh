# RabbitMQ: install and start the server
sudo apt-get -y install rabbitmq-server --fix-missing
sudo service rabbitmq-server start

# RabbitMQ: enable HTTP management port
sudo rabbitmq-plugins enable rabbitmq_management

# RabbitMQ: create user and add the administrator tag
sudo rabbitmqctl add_user learn_vault hashicorp
sudo rabbitmqctl set_user_tags learn_vault administrator
