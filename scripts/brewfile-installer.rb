#!/usr/bin/env ruby
# frozen_string_literal: true

class PackageInstaller
  def initialize(cmd: 'brew')
    @require_packages = {}
    @platform = `uname`.split(/\s+/).first.to_sym.downcase

    @cmd = cmd
  end

  def add_with(*subcmd, &block)
    cmdlist = [@cmd] + subcmd.map(&:to_s)
    packages = yield block
    add packages, cmdlist: cmdlist
  end

  def add(*packages, cmdlist: [@cmd])
    cmd = cmdlist.join(' ')

    @require_packages[cmd] = [] if @require_packages[cmd].nil?

    @require_packages[cmd] += packages.flatten.map(&:to_s)
  end

  def platform?(*platforms)
    platforms.map(&:to_sym).map(&:downcase).include? @platform
  end

  def install
    @require_packages.each do |cmd, require_packages|
      installed_packages = `#{cmd} list`.split(/\s+/)
      install_packages = require_packages.filter do |p|
        !installed_packages.include? File.basename p
      end

      next if install_packages.empty?

      install_cmd = cmd.split(/\s/) + ['install'] + install_packages
      puts install_cmd.join ' '
      raise unless system(*install_cmd)
    end
  end

  def upgrade
    @require_packages.each do |cmd, require_packages|
      next if require_packages.empty?

      upgrade_cmd = cmd.split(/\s/) + ['upgrade']
      puts upgrade_cmd.join ' '
      raise unless system(*upgrade_cmd)
    end
  end
end

brew = PackageInstaller.new

Dir.glob("#{__dir__}/brewfile{,\.*}").each do |filename|
  brew.instance_eval File.read filename if File.exist? filename
end

brew.install
brew.upgrade
