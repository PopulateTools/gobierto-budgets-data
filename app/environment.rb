require 'csv'
require 'ostruct'
require 'fileutils'
require 'rubygems'
require 'bundler/setup'
Bundler.require

require 'active_support/all'
require 'active_record'

ROOT = File.join(File.dirname(__FILE__), '..')

module INE; end
module PresupuestosMunicipales; end

require_relative './ine/csv_record'
Dir.glob('app/ine/*.rb').each{ |f| require_relative '../'+f }

INE::AutonomousRegionsCollection.records
INE::ProvincesCollection.records
INE::PlacesCollection.records

Dir.glob('app/presupuestos_municipales/*.rb').each{ |f| require_relative '../'+f }
