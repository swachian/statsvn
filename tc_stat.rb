require "stat"
require "test/unit"

$repo =  ARGV[0]

class TC_Stat < Test::Unit::TestCase
  def setup
    @svncmd = Svncmd.new($repo)
  end
  def test_listfile
    files = @svncmd.listfile('/', 'java')
    assert_kind_of Array, files 
    files[0..10].each { |f| assert_match /java$/, f}
    assert_kind_of String, files[0]
  end
  
  def test_wlcat
    file =  @svncmd.listfile('/', 'java')[0]
    assert_kind_of Integer,  @svncmd.wlfile(file)
  end

  def test_fileslinecount
    files = @svncmd.listfile('/', 'java')[0..1]
    loc1 = @svncmd.wlfile(files[0])
    loc2 = @svncmd.wlfile(files[1])
    locs, fileno = @svncmd.wlfiles(files)
    assert locs = loc1+loc2
    assert_equal 2, fileno
  end

  def test_statonetype
    loc, fileno =  @svncmd.statonetype('/', 'java')
    assert_kind_of Integer, loc
    assert_kind_of Integer, fileno
    assert loc > 0
  end
end
