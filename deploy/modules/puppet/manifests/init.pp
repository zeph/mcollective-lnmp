class puppet {
   package{"puppet":
      ensure => latest,
      require => Class["repos"]
   }
}
