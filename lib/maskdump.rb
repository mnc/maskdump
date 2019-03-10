require "maskdump/version"

module Maskdump
  autoload :Command, "maskdump/command"
  autoload :Setting, 'maskdump/setting'
  autoload :Table, 'maskdump/table'
  autoload :Mask, 'maskdump/mask'
  autoload :BulkInsert, 'maskdump/bulk_insert'
  autoload :Dump, 'maskdump/dump'
end
