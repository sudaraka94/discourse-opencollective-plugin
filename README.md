# discourse-opencollective-plugin

This is intended to be a feature-rich plugin for opencollective-discourse integration

![img](https://preview.ibb.co/jnL55a/Screenshot_from_2017_04_02_13_02_58.png)

The plugin has been hard coded to get the sponsors for "webpack" collective from Opencollective.com as it has many sponsors. It updates the user list every two seconds using a sidekiq job. I have used two every two seconds for the ease of development and the real time interval have to be longer than this. It will show the list of sponsors in the admin interface : **/admin/plugins/opencollective**
