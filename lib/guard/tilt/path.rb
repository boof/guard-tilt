class Guard::Tilt::Path < Struct.new(:to_str)
  Guard::Tilt.path = self

  # Template Method
  def sanitize
    strip_extname
  end

  def join(other)
    new File.join(to_str, other.to_str)
  end
  def sub(base, root)
    new to_str.sub(base, root)
  end

  def extname
    new File.extname(to_str)
  end
  def basename(*args)
    new File.basename(to_str, *args)
  end
  def dirname
    new File.dirname(to_str)
  end
  def expand(*args)
    new File.expand_path(to_str, *args)
  end

  def strip_extname
    expand.dirname.join basename(extname)
  end

  def to_s(base = nil)
    unless base
      sanitize.to_str
    else
      base += File::Separator if base !~ /\/$/
      sanitize.sub(base, '').to_str
    end
  end
  def open(mode = 'r', &block)
    File.open(to_s, mode, &block)
  end

  protected

    def new(str)
      instance = dup
      instance.to_str = str
      instance
    end

end
