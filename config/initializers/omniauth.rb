Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitch, "h64fm07khcrakk19z884lrp70w7x4de", "cbj4y40xwty392d2ltxe048nv3b7p0y", {:provider_ignores_state => true}
end