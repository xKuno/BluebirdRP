--====================================================================================
-- #Author: Jonathan D @ Gannon
--====================================================================================

RegisterNetEvent('075f1a43-1200-4b57-be50-9c869459f0d9')
AddEventHandler('075f1a43-1200-4b57-be50-9c869459f0d9', function(tweets)
  SendNUIMessage({event = 'twitter_tweets', tweets = tweets})
end)

RegisterNetEvent('5e63d8bd-6dcc-461c-b377-4b260dbca03c')
AddEventHandler('5e63d8bd-6dcc-461c-b377-4b260dbca03c', function(tweets)
  SendNUIMessage({event = 'twitter_favoritetweets', tweets = tweets})
end)

RegisterNetEvent('c2260d41-d0a9-45d6-bf47-60333c8859ac')
AddEventHandler('c2260d41-d0a9-45d6-bf47-60333c8859ac', function(tweets)
  SendNUIMessage({event = 'twitter_UserTweets', tweets = tweets})
end)

RegisterNetEvent('897c5040-8169-432c-a645-f61995bb1099')
AddEventHandler('897c5040-8169-432c-a645-f61995bb1099', function(tweet)
  SendNUIMessage({event = 'twitter_newTweet', tweet = tweet})
end)

RegisterNetEvent('b1c038ce-0e65-41cb-85f7-ffe286bf9669')
AddEventHandler('b1c038ce-0e65-41cb-85f7-ffe286bf9669', function(tweetId, likes)
  SendNUIMessage({event = 'twitter_updateTweetLikes', tweetId = tweetId, likes = likes})
end)

RegisterNetEvent('30ab77b3-903e-4478-b853-f28443c27e29')
AddEventHandler('30ab77b3-903e-4478-b853-f28443c27e29', function(username, password, avatarUrl)
  SendNUIMessage({event = 'twitter_setAccount', username = username, password = password, avatarUrl = avatarUrl})
end)

RegisterNetEvent('0960b8cf-61b9-4524-ba3e-08a26f443025')
AddEventHandler('0960b8cf-61b9-4524-ba3e-08a26f443025', function(account)
  SendNUIMessage({event = 'twitter_createAccount', account = account})
end)

RegisterNetEvent('475d128e-aac1-4389-8216-756dd9227a0d')
AddEventHandler('475d128e-aac1-4389-8216-756dd9227a0d', function(title, message, image)
  SendNUIMessage({event = 'twitter_showError', message = message, image = image, title = title})
end)

RegisterNetEvent('b6443710-40e3-4711-b1d6-7f9ff4c7e9e5')
AddEventHandler('b6443710-40e3-4711-b1d6-7f9ff4c7e9e5', function(title, message, image)
  SendNUIMessage({event = 'twitter_showSuccess', message = message, image = image, title = title})
end)

RegisterNetEvent('83119688-2510-4a6c-80d0-419696272c0c')
AddEventHandler('83119688-2510-4a6c-80d0-419696272c0c', function(tweetId, isLikes)
  SendNUIMessage({event = 'twitter_setTweetLikes', tweetId = tweetId, isLikes = isLikes})
end)





RegisterNUICallback('twitter_userssDeleteTweet', function(data, cb) 
  TriggerServerEvent('f02f9d00-79f8-4294-a1f3-1069e1a0ac0b', data.username or '', data.password or '', data.tweetId)
end)

RegisterNUICallback('twitter_login', function(data, cb)
  TriggerServerEvent('96c8c0dc-08dc-4bef-a904-0e40ffaa20ed', data.username, data.password)
end)
RegisterNUICallback('twitter_changePassword', function(data, cb)
  TriggerServerEvent('14463d12-dd3f-4f5e-9eca-8406bbcaf82e', data.username, data.password, data.newPassword)
end)


RegisterNUICallback('twitter_createAccount', function(data, cb)
  TriggerServerEvent('fd7cff70-5e97-4f98-b9db-03c7d994e37a', data.username, data.password, data.avatarUrl)
end)

RegisterNUICallback('twitter_getTweets', function(data, cb)
  TriggerServerEvent('abdb07cc-c4c9-4698-8623-380baf3b599e', data.username, data.password)
end)

RegisterNUICallback('twitter_getFavoriteTweets', function(data, cb)
  TriggerServerEvent('bd9bb351-c0dc-4001-a7dc-cba98431a089', data.username, data.password)
end)

RegisterNUICallback('twitter_getUserTweets', function(data, cb)
  TriggerServerEvent('d08a2ad0-1f2f-42b2-8dea-ab9bdc9e3068', data.username, data.password)
  print(data.username)
end)

RegisterNUICallback('twitter_postTweet', function(data, cb)
  TriggerServerEvent('e83f8695-8f73-4754-95cb-df585437bd44', data.username or '', data.password or '', data.message or '', data.image)
  print(data.message)
  print(data.image)
end)

RegisterNUICallback('twitter_toggleLikeTweet', function(data, cb)
  TriggerServerEvent('9c9b6a4b-9ce2-4d3b-b959-f555d778cf8a', data.username or '', data.password or '', data.tweetId)
end)

RegisterNUICallback('twitter_setAvatarUrl', function(data, cb)
  TriggerServerEvent('9295c728-39a9-4634-8830-01e5efef71ac', data.username or '', data.password or '', data.avatarUrl)
end)
