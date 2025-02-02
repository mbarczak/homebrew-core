class Gitless < Formula
  include Language::Python::Virtualenv

  desc "Simplified version control system on top of git"
  homepage "https://gitless.com/"
  url "https://files.pythonhosted.org/packages/9c/2e/457ae38c636c5947d603c84fea1cf51b7fcd0c8a5e4a9f2899b5b71534a0/gitless-0.8.8.tar.gz"
  sha256 "590d9636d2ca743fdd972d9bf1f55027c1d7bc2ab1d5e877868807c3359b78ef"
  license "MIT"
  revision 15

  bottle do
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "9f4b487e1f75ce43d64d7a9e80790c216564f212f4a5da7fafba626c3a8e901e"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "9f4b487e1f75ce43d64d7a9e80790c216564f212f4a5da7fafba626c3a8e901e"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9f4b487e1f75ce43d64d7a9e80790c216564f212f4a5da7fafba626c3a8e901e"
    sha256 cellar: :any_skip_relocation, sonoma:         "26ff00d734d1bcf6a3be5e67713db3afc6dccd7e1ae4ea4b1f7b5842548a8556"
    sha256 cellar: :any_skip_relocation, ventura:        "26ff00d734d1bcf6a3be5e67713db3afc6dccd7e1ae4ea4b1f7b5842548a8556"
    sha256 cellar: :any_skip_relocation, monterey:       "26ff00d734d1bcf6a3be5e67713db3afc6dccd7e1ae4ea4b1f7b5842548a8556"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2a7a5a9e64e8a5a19353c9169f19e055a8358a25f00e5bf19d1b1615770c6738"
  end

  depends_on "pygit2"
  depends_on "python@3.12"

  uses_from_macos "libffi"

  on_linux do
    depends_on "pkg-config" => :build
  end

  resource "args" do
    url "https://files.pythonhosted.org/packages/e5/1c/b701b3f4bd8d3667df8342f311b3efaeab86078a840fb826bd204118cc6b/args-0.1.0.tar.gz"
    sha256 "a785b8d837625e9b61c39108532d95b85274acd679693b71ebb5156848fcf814"
  end

  resource "clint" do
    url "https://files.pythonhosted.org/packages/3d/b4/41ecb1516f1ba728f39ee7062b9dac1352d39823f513bb6f9e8aeb86e26d/clint-0.5.1.tar.gz"
    sha256 "05224c32b1075563d0b16d0015faaf9da43aa214e4a2140e51f08789e7a4c5aa"
  end

  resource "sh" do
    url "https://files.pythonhosted.org/packages/7c/71/199d27d3e7e78bf448bcecae0105a1d5b29173ffd2bbadaa95a74c156770/sh-1.12.14.tar.gz"
    sha256 "b52bf5833ed01c7b5c5fb73a7f71b3d98d48e9b9b8764236237bdc7ecae850fc"
  end

  # Allow to be dependent on pygit2 1.9.0
  # Remove for next version
  patch :DATA

  def install
    virtualenv_install_with_resources
  end

  test do
    system "git", "config", "--global", "user.email", '"test@example.com"'
    system "git", "config", "--global", "user.name", '"Test"'
    system bin/"gl", "init"
    %w[haunted house].each { |f| touch testpath/f }
    system bin/"gl", "track", "haunted", "house"
    system bin/"gl", "commit", "-m", "Initial Commit"
    assert_equal "haunted\nhouse", shell_output("git ls-files").strip
  end
end

__END__
diff --git a/requirements.txt b/requirements.txt
index 05f190a..6777cce 100644
--- a/requirements.txt
+++ b/requirements.txt
@@ -1,6 +1,6 @@
 # make sure to update setup.py

-pygit2==0.28.2  # requires libgit2 0.28
+pygit2==1.10.0  # requires libgit2 0.28
 clint==0.5.1
 sh==1.12.14;sys_platform!='win32'
 pbs==0.110;sys_platform=='win32'
diff --git a/setup.py b/setup.py
index 68a3a87..388ca66 100755
--- a/setup.py
+++ b/setup.py
@@ -68,7 +68,7 @@ setup(
     packages=['gitless', 'gitless.cli'],
     install_requires=[
       # make sure it matches requirements.txt
-      'pygit2==0.28.2', # requires libgit2 0.28
+      'pygit2==1.10.0', # requires libgit2 0.28
       'clint>=0.3.6',
       'sh>=1.11' if sys.platform != 'win32' else 'pbs>=0.11'
     ],
