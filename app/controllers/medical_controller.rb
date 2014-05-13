# encoding: utf-8

class MedicalController < ApplicationController
  require 'sequel'
  def search
    puts  params
    puts  params[:source]

    source = params[:source]
    sourceno = params[:sourceid]
    p source

    @users = User.all
    #source 门诊    0
    #source 住院    1
    #source 急诊    2
    if  0.to_s.eql? source
      @clinicals = {}
      @clinicals = ClinicMaster.where(:visit_no => sourceno).first
      puts " ^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
      puts @clinicals
      puts " ^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
      if @clinicals.nil?
         @clinicals = {}
      end
      render json:  "#{@clinicals}"
    elsif  1.to_s.eql? source
      @inpatient =  WaitBedPat.where(:visit_no => sourceno).first
      puts @inpatient

      render json:  @clinicals

    elsif 2.to_s.eql? source
      render :json => '{}'
    end



    #puts  @users

    #require 'sequel'
=begin
    DB = Sequel.oracle('orcl', :host=>'192.168.1.46', :user=>'yxf', :password=>'yxf', :encoding => 'utf8')
    DB['select * from user_test'].each  do |row|
      p  row
    endra
=end
=begin
    DB[:user_test][:name => '张三丰']
    # SELECT * FROM artists WHERE (name = 'YJM') LIMIT 1
    => {:name=>"YJM", :id=>1}
=end
  end

  private
  def ClinicMaster_params
    params.require(:user).permit(:name, :age)
  end


end
