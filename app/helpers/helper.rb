def active_page?(path='')
  request.path_info == '/' + path
end