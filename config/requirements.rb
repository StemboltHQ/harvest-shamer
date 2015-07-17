require 'rubygems'
require 'bundler/setup'
require 'net/smtp'
require_relative 'settings'
require_relative '../models/application'
require_relative '../models/time_tracker'
require_relative '../models/user'
require_relative '../models/log'
require_relative '../models/notification'
require_relative '../models/notes_notification'

Bundler.require(:default)
