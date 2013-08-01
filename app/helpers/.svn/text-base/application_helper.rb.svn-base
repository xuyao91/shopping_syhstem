# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
 def will_paginate_remote(paginator, options={})
    function = options.delete(:after)
    update = options.delete(:update)
    url = options.delete(:url)
    str = will_paginate(paginator, options)
    if url[0..0]!="/"
      url = "/"+url
    end
    if str != nil
      str.gsub(/href="(.*?)"/) do
        "href=\"javascript:void(0)\" onclick=\"new Ajax.Updater('" + update.to_s + "', '" + (url ? url + $1.sub(/[^\?]*/, '') : $1) +
         "', {asynchronous:true, evalScripts:true, method:'get'}); #{function}; return false;\""
      end
    end
  end  
  
end
