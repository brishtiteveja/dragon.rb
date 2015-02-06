module Dictation
  class ShowExpressEditor < ActionBuilder
    def initialize
      @command_type = 'AppleScript'
      @action = <<-APPLESCRIPT.align_left
        set _dictateApp to (name of current application)
        tell application _dictateApp
          show express editor
        end tell
        tell application _dictateApp
          set microphone to dictation
        end tell
      APPLESCRIPT
    end
  end
end
