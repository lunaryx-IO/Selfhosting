rspamd_config:register_symbol({
  name = 'WERKPOST_FROM_MATCH',
  type = 'prefilter',
  priority = 100,
  flags = 'empty,explicit_disable,ignore_passthrough',
  callback = function(task)
    local user = task:get_user()
    if not user or user == '' then
      return false
    end

    local headers = task:get_header_full('From') or {}
    local mime = task:get_from('mime') or {}
    local smtp = task:get_from('smtp') or {}
    local valid = #headers == 1 and #mime == 1 and #smtp == 1
    if valid then
      local m, s = mime[1], smtp[1]
      valid = m.flags and m.flags.valid and s.flags and s.flags.valid
        and type(m.addr) == 'string' and type(s.addr) == 'string'
        and m.addr ~= '' and s.addr ~= ''
        and string.lower(m.addr) == string.lower(s.addr)
    end

    if not valid then
      task:set_pre_result('reject',
        'From address must match the authorized envelope sender',
        'werkpost_from')
      return true
    end
    return false
  end,
})
