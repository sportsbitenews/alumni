class AddSlackChannelNameToCities < ActiveRecord::Migration[5.0]
  def change
    add_column :cities, :slack_channel_name, :string
    City.find_by_slug('montreal').update(slack_channel_name: 'montreal')
    City.find_by_slug('shanghai').update(slack_channel_name: 'shanghai')
    City.find_by_slug('rio').update(slack_channel_name: 'brazil')
    City.find_by_slug('belo-horizonte').update(slack_channel_name: 'brazil')
    City.find_by_slug('sao-paulo').update(slack_channel_name: 'brazil')
    City.find_by_slug('barcelona').update(slack_channel_name: 'barcelona')
    City.find_by_slug('lyon').update(slack_channel_name: 'lyon_strat')
    City.find_by_slug('london').update(slack_channel_name: 'london')
    City.find_by_slug('copenhagen').update(slack_channel_name: 'copenhagen')
    City.find_by_slug('nantes').update(slack_channel_name: 'nantes')
    City.find_by_slug('amsterdam').update(slack_channel_name: 'benelux')
    City.find_by_slug('lisbon').update(slack_channel_name: 'lisbon')
    City.find_by_slug('aix-marseille').update(slack_channel_name: 'marseille')
    City.find_by_slug('bordeaux').update(slack_channel_name: 'bordeaux')
    City.find_by_slug('beirut').update(slack_channel_name: 'beyrouth')
    City.find_by_slug('lille').update(slack_channel_name: 'lille')
    City.find_by_slug('brussels').update(slack_channel_name: 'benelux')
    City.find_by_slug('paris').update(slack_channel_name: 'paris')
  end
end
