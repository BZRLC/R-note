# Awesome NLP in R

小赵搜集的关于自然语言处理相关的R包：

  - [分词相关的包](#chinese-text-segmentation)
    - jiebaR
    - cppjieba
    - THULAC
  - [向量化](#document-term-matrix)
    - text2vec
    - wordVectors
  - [文本回归与去重](#text-regression-and-document-similarity)
    - textreg
    - textreuse
    - stringdist
  - [文本定量分析与主题模型](#quantitative-analysis-of-textual-data)
    - quanteda
    - topicmodels
    - lda
    - LDAvis
    - mallet
    - stm
  - [补充](#implemention-from-awesome-r)
    - tm
    - openNLP
    - koRpus
    - zipfR
    - tmcn
    - Rwordseg
    - NLP
    - syuzhet
    - SnowballC
  - [CRAN Task View](#cran-task-view)

## Chinese Text Segmentation

* [jiebaR](https://github.com/qinwf/jiebaR) - 基于c++的R分词包，支持keywords,simhash,海明距离...(首推)

* [cppjieba](https://github.com/yanyiwu/cppjieba) - c++ 分词工具

* [THULAC](http://thulac.thunlp.org/) - 一个高效的中文词法分析工具包,清华大学荣誉出品,目前只有持Python，c++,java.

## Document-Term Matrix

* [text2vec](https://cran.r-project.org/web/packages/text2vec/vignettes/text-vectorization.html) - c++ 写的,基于standford的[glove](http://www-nlp.stanford.edu/projects/glove/) 的API,占用内存小.vignette：[text2vec 0.3](http://dsnotes.com/articles/text2vec-0-3) [GloVe vs word2vec revisited](http://dsnotes.com/articles/glove-enwiki)

* [wordVectors](https://github.com/bmschmidt/wordVectors) - An R package for building and exploring Word2Vec models.基于李舰封装word2vec里面的C代码,需要注意的目前在win8下不能安装，其他的环境都可以.

## Text Regression and Document Similarity

* [textreg](https://cran.r-project.org/web/packages/textreg/) -  n-Gram Text Regression, aka Concise Comparative Summarization

* [textreuse](https://cran.r-project.org/web/packages/textreuse/vignettes/textreuse-introduction.html) - provides classes and functions to detect document similarity and text reuse in text corpora.
* [stringdist](https://cran.r-project.org/web/packages/stringdist/) - Approximate String Matching and String Distance Functions.可以计算hamming distance等等...

## Quantitative Analysis of Textual Data

* [quanteda](https://cran.r-project.org/web/packages/quanteda/vignettes/quickstart.html) - c++写的，分析基于"dfm",依赖`stingi`,`data.table`等包，效率还是比较高的；另外还需要加载依赖的主题模型的包,例如`lda`,`topicmodels`等.[快速上手文档](http://kbenoit.github.io/quanteda/intro/overview.html);  [github地址](https://github.com/kbenoit/quanteda).
* [topicmodels](https://cran.r-project.org/web/packages/topicmodels/index.html) - Provides an interface to the C code for Latent Dirichlet Allocation (LDA) models and Correlated Topics Models (CTM) [更多请看这里](https://github.com/trinker/topicmodels_learning)
* [lda](https://cran.r-project.org/web/packages/lda/index.html) - Implements latent Dirichlet allocation (LDA) and related models.
* [LDAvis](https://github.com/cpsievert/LDAvis) - Interactive visualization of topic models.
* [mallet](https://cran.r-project.org/web/packages/mallet/index.html) - This package allows you to train topic models in mallet and load results directly into R.基于JAVA
* [stm](https://cran.r-project.org/web/packages/stm/) - Estimation of the Structural Topic Model.基于C

主题模型可以参考这里的比较和例子：<https://github.com/trinker/topicmodels_learning#r-resources>

##  Implemention from [Awesome R](https://github.com/qinwf/awesome-R/blob/master/README.md#natural-language-processing) 
*Packages for Natural Language Processing.* 
* [tm](http://cran.r-project.org/web/packages/tm/index.html) - A comprehensive text mining framework for R.
* [openNLP](http://cran.r-project.org/web/packages/openNLP/index.html) - Apache OpenNLP Tools Interface.
* [koRpus](http://cran.r-project.org/web/packages/koRpus/index.html) - An R Package for Text Analysis.
* [zipfR](http://cran.r-project.org/web/packages/zipfR/index.html) - Statistical models for word frequency distributions.
* [NLP](http://cran.r-project.org/web/packages/NLP/index.html) - Basic functions for Natural Language Processing.
* [syuzhet](https://cran.r-project.org/web/packages/syuzhet/index.html) - Extracts sentiment from text using three different sentiment dictionaries.
* [SnowballC](https://cran.rstudio.com/web/packages/SnowballC/index.html) - Snowball stemmers based on the C libstemmer UTF-8 library.


## CRAN Task View

<https://cran.r-project.org/web/views/NaturalLanguageProcessing.html>

