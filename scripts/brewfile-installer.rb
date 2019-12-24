#!/usr/bin/env ruby
# frozen_string_literal: true

class PackageInstaller
  def initialize(cmd: ['brew'])
    @require_packages = []
    @platform = `uname`.split(/\s+/).first.to_sym.downcase

    @cmd = cmd
  end

  def use(*packages)
    @require_packages += packages.map(&:to_s)
  end

  def platform?(*platforms)
    platforms.map(&:to_sym).map(&:downcase).include? @platform
  end

  def install
    installed_packages = `#{@cmd.join ' '} list`.split(/\s+/)
    install_packages = @require_packages.filter do |p|
      !installed_packages.include? File.basename p
    end

    install_cmd = @cmd + ['install'] + install_packages

    return if install_packages.empty?

    puts install_cmd.join ' '
    raise unless system(*install_cmd)
  end

  def upgrade
    return if @require_packages.empty?

    upgrade_cmd = @cmd + ['upgrade']
    puts upgrade_cmd.join ' '
    raise unless system(*upgrade_cmd)
  end

  def cleanup
    cleanup_cmd = @cmd + ['cleanup']
    puts cleanup_cmd.join ' '
    raise unless system(*cleanup_cmd)
  end
end

brew = PackageInstaller.new

%w[
  brewfile
  brewfile.local
].each do |filename|
  brew.instance_eval File.read filename if File.exist? filename
end

brew.install
brew.upgrade

brewcask = PackageInstaller.new(cmd: %w[brew cask])

%w[
  cask.brewfile
  cask.brewfile.local
].each do |filename|
  brewcask.instance_eval File.read filename if File.exist? filename
end

brewcask.install
brewcask.upgrade

brew.cleanup
