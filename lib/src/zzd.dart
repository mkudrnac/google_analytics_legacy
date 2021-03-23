class ZZD {
  static String zzd(final int var0) {
    return _zza("&cd", var0);
  }

  static String zze(final int var0) {
    return _zza("cd", var0);
  }

  static String zzf(final int var0) {
    return _zza("&cm", var0);
  }

  static String zzg(final int var0) {
    return _zza("cm", var0);
  }

  static String zzh(final int var0) {
    return _zza("&pr", var0);
  }

  static String zzi(final int var0) {
    return _zza("pr", var0);
  }

  static String zzj(final int var0) {
    return _zza("&promo", var0);
  }

  static String zzk(final int var0) {
    return _zza("promo", var0);
  }

  static String zzl(final int var0) {
    return _zza("pi", var0);
  }

  static String zzm(final int var0) {
    return _zza("&il", var0);
  }

  static String zzn(final int var0) {
    return _zza("il", var0);
  }

  static String zzo(final int var0) {
    return _zza("cd", var0);
  }

  static String zzp(final int var0) {
    return _zza("cm", var0);
  }

  static String _zza(final String var0, final int var1) {
    if (var1 <= 0) {
      assert(false, "index out of range for prefix " + var0);
      return "";
    } else {
      return "$var0$var1";
    }
  }
}
