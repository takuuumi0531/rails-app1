class BooksController < ApplicationController
#show ・投稿、編集した後表示するページ
  def show
    @book = Book.find(params[:id])
    #showページに入力した内容を受け渡す
    #単体だけの表示のため@bookと単数形
  end
#index データの一覧を表示する
  def index
    @books = Book.all
    #保存されたすべてを出力
    @book = Book.new
    #新規投稿
  end
#new ・新規投稿のページ。今回はindexページに表示するため使用せず。
  def new
    @book = Book.new
  end
#create ・投稿、編集したものを保存するアクション。
#ページは変わらないためhttp methodはpost(rails routes参照)
#コントローラーアクション一番下のbook paramsとセットで作成
  def create
    
    #以下無入力エラー設定コード
    #データを新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    if @book.save
    #データをデータベースに保存するためのsaveメソッド実行
    #showページにリダイレクト(pathはrails routeで確認)
    redirect_to book_path(@book.id)
    else
    @books = Book.all
    #indexページにリダイレクト
    render :index
    end
    
  end
#edit ・投稿されたものを編集するページ
  def edit
    @book = Book.find(params[:id])
  end
#update ・新規投稿や編集して更新するもの
  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    #更新後showページへ
    redirect_to book_path(@book)
  end
#destroy ・投稿し保存したものを消去するアクション
  def destroy
    book = Book.find(params[:id])
    book.destroy
    #投稿削除後indexページへ
    redirect_to books_path
  end
  
  private
  
   # ストロングパラメータ
   #createアクションとセット
  def book_params
    params.require(:book).permit(:title, :body)
  end
  

end
