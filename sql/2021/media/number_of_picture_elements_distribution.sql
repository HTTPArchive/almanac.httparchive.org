SELECT FORMAT( "%T", APPROX_QUANTILES( 
    CAST(
        JSON_QUERY( JSON_VALUE( payload, "$._media" ), "$.num_picture_img" )
        AS INT64
    ),
    100 IGNORE NULLS
) ) as approx_qauantiles
FROM `httparchive.sample_data.pages_mobile_10k`