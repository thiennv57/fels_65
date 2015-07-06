class Admin::ImportsController < ApplicationController
  def create
    if file = params[:file]
      import_csv file
      flash[:success] = t("import_successfully").capitalize
    else
      flash[:danger] = t("file_is_required").capitalize
    end
    redirect_to admin_words_path
  end

  private
  def import_csv file
    CSV.open(file.path, "rt", headers: true).each do |row|
      category_name = row["category_name"]
      category_description = row["category_description"]
      word_word = row["word"]
      word_mean = row["mean"]
      is_correct = row["is_correct"]

      category = save_changes(Category, {name: category_name},
                              {name: category_name, description: category_description})
      word = save_changes(Word, {word: word_word},
                          {word: word_word, category_id: category.id})
      save_changes(Answer, {mean: word_mean, word_id: word.id},
                  {word_id: word.id, mean: word_mean, is_correct: is_correct})
    end
  end

  def save_changes model, fields_to_check, data
    if (existedCategory = model.find_by fields_to_check)
      existedCategory.update_attributes data
      existedCategory
    else
      model.create! data
    end
  end
end
