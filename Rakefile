# frozen_string_literal: true

require 'bundler/setup'
require 'bundler/gem_tasks'
require 'minitest/test_task'

Minitest::TestTask.create do |t|
  t.libs << 'test' << 'lib'
  t.warning = false
  t.test_prelude = 'require "test_helper"'
  t.test_globs = ['test/**/*_test.rb']
end

task default: :test
