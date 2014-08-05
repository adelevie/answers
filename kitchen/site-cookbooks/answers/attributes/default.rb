#
# Cookbook Name:: answers
# Attributes:: default
#
default['answers']['rails']['env']										= 'production'
default['answers']['ruby']['version']									= '2.1.2'

###########
# env setup
###########

# app vars
default['answers']['env']['background_image']					= '/assets/background_image.jpg'
default['answers']['env']['city_name']								= 'answers'
default['answers']['env']['site_title']								= 'answers platform'
default['answers']['env']['url']											= 'http://example.gov'
default['answers']['env']['email']										= 'contact@example.gov'
default['answers']['env']['sytle_guide']							= 'http://example.gov'

# 3rd party config + keys
default['answers']['env']['coveralls_run_locally']		= false
default['answers']['env']['coveralls_token']					= nil
default['answers']['env']['google_analytics_key']			= nil
default['answers']['env']['new_relic_key']						= nil
default['answers']['env']['s3_bucket']								= nil
default['answers']['env']['s3_key']										= nil
default['answers']['env']['s3_secret']								= nil
default['answers']['env']['secret_key_base']					= '29530da3e01ab7094b2d37ab76da69c96e14eb49bd60d769897dc556e7eb0e0cab7ec0f811c1f61f6512ddf074b7c1caa4cf7f26678ffeaac7ccf7e30288e18a'
default['answers']['env']['secret_token']							= 'd6a6cd0c45e59a27e3ace0d7280a2c01dbeab7595620e3ac77378ac74ceae64d0ec17bfeefa3bff995853594bb93e0197bba23f947d11deb4d7f7baf890e5f07'
