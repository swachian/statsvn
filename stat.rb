class Svncmd
  def initialize(repo)
    @repo = repo
    puts repo
  end
  def listfile(path, filetype)
    s = `svnlook tree #{@repo} #{path} --full-paths | grep #{filetype}$ | grep -v tags`
    s.split(/\n/)
  end
  
  def catfile(filepath)
    f = `svnlook cat  #{@repo} #{filepath}`
  end 
  
  def wlfile(filepath)
    linenumber = `svnlook cat  #{@repo} #{filepath} | wc -l`.to_i
  end

  def wlfiles(files)
    loc, fileno = 0, 0
    files.each do |f|
      loc += wlfile(f)
      fileno += 1
    end
    [loc, fileno]
  end
  
  def statonetype(path, filetype)
    files = listfile(path, filetype)
    wlfiles files
  end
  
end

def stat 
  svn = Svncmd.new(ARGV[0])
  ['java', 'jsp', 'xml'].each do |type|
    print type + " \t\t"
    p svn.statonetype(ARGV[1], type)
  end
end
