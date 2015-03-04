# if (data.domain == "i.imgur.com" && !isImgurVid(data.url))
# {
#     return prefix + suffix;
# }
# else if (data.domain == "i.imgur.com" && isImgurVid(data.url))
# {
#     var nakedUrl = data.url.split(data.url.match(/\.([A-Za-z0-9]+)$/g)[0])[0];
#     var embededVideo = "<video autoplay loop muted preload id='storyimage'>";
# embededVideo += "<source src='" + nakedUrl + ".webm' type='video/webm'>";
#     embededVideo += "<source src='" + nakedUrl + ".mp4' type='video/mp4'>";
# embededVideo += "</video>";

# return embededVideo;
# }

# function isImgurVid(url)
# # // Returns true if url is .gifv, .webm, or .mp4
# {
#     var exts = [".gifv", ".webm", ".mp4"];
#     for (var i in exts) {
#         if(url.indexOf(exts[i]) == url.length - exts[i].length) return true;
#     }
#     return false;
# }
