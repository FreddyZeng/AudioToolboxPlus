#import "ATPAudioConverter+Properties.h"

#import "NSValue+ATPAudioValueRange.h"


@implementation ATPAudioConverter (Properties)

- (UInt32)minimumInputBufferSize
{
	return [self minimumInputBufferSizeWithError:nil];
}

- (UInt32)minimumInputBufferSizeWithError:(NSError **)error
{
	UInt32 value = 0;
	UInt32 size = sizeof(value);
	
	[self getValue:&value size:&size forProperty:kAudioConverterPropertyMinimumInputBufferSize error:error];
	
	return value;
}

- (UInt32)minimumOutputBufferSize
{
	return [self minimumOutputBufferSizeWithError:nil];
}

- (UInt32)minimumOutputBufferSizeWithError:(NSError **)error
{
	UInt32 value = 0;
	UInt32 size = sizeof(value);
	
	[self getValue:&value size:&size forProperty:kAudioConverterPropertyMinimumOutputBufferSize error:error];
	
	return value;
}

- (UInt32)maximumInputBufferSize
{
	return [self maximumInputBufferSizeWithError:nil];
}

- (UInt32)maximumInputBufferSizeWithError:(NSError **)error
{
	UInt32 value = 0;
	UInt32 size = sizeof(value);
	
	[self getValue:&value size:&size forProperty:kAudioConverterPropertyMaximumInputBufferSize error:error];
	
	return value;
}

- (UInt32)maximumInputPacketSize
{
	return [self maximumInputPacketSizeWithError:nil];
}

- (UInt32)maximumInputPacketSizeWithError:(NSError **)error
{
	UInt32 value = 0;
	UInt32 size = sizeof(value);
	
	[self getValue:&value size:&size forProperty:kAudioConverterPropertyMaximumInputPacketSize error:error];
	
	return value;
}

- (UInt32)maximumOutputPacketSize
{
	return [self maximumOutputPacketSizeWithError:nil];
}

- (UInt32)maximumOutputPacketSizeWithError:(NSError **)error
{
	UInt32 value = 0;
	UInt32 size = sizeof(value);
	
	[self getValue:&value size:&size forProperty:kAudioConverterPropertyMaximumOutputPacketSize error:error];
	
	return value;
}

- (NSData *)magicCookie
{
	return [self magicCookieWithError:nil];
}

- (NSData *)magicCookieWithError:(NSError **)error
{
	return [self dataForProperty:kAudioConverterCompressionMagicCookie error:error];
}

- (UInt32)codecQuality
{
	return [self codecQualityWithError:nil];
}

- (UInt32)codecQualityWithError:(NSError **)error
{
	UInt32 value = { 0 };
	UInt32 size = sizeof(value);
	
	[self getValue:&value size:&size forProperty:kAudioConverterCodecQuality error:error];
	
	return value;
}

- (BOOL)setCodecQuality:(UInt32)codecQuality
{
	return [self setCodecQuality:codecQuality error:nil];
}

- (BOOL)setCodecQuality:(UInt32)codecQuality error:(NSError **)error
{
	UInt32 value = codecQuality;
	
	return [self setValue:&value size:sizeof(value) forProperty:kAudioConverterCodecQuality error:error];
}

- (UInt32)encodeBitRate
{
	return [self encodeBitRateWithError:nil];
}

- (UInt32)encodeBitRateWithError:(NSError **)error
{
	UInt32 value = { 0 };
	UInt32 size = sizeof(value);
	
	[self getValue:&value size:&size forProperty:kAudioConverterEncodeBitRate error:error];
	
	return value;
}

- (BOOL)setEncodeBitRate:(UInt32)encodeBitRate
{
	return [self setEncodeBitRate:encodeBitRate error:nil];
}

- (BOOL)setEncodeBitRate:(UInt32)encodeBitRate error:(NSError **)error
{
	UInt32 value = encodeBitRate;
	
	return [self setValue:&value size:sizeof(value) forProperty:kAudioConverterEncodeBitRate error:error];
}

- (NSArray *)applicableEncodeBitRates
{
	return [self applicableEncodeBitRatesWithError:nil];
}

- (NSArray *)applicableEncodeBitRatesWithError:(NSError **)error
{
	NSData *data = [self dataForProperty:kAudioConverterApplicableEncodeBitRates error:error];
	
	const AudioValueRange *bytes = data.bytes;
	const NSUInteger count = data.length / sizeof(AudioValueRange);
	
	NSMutableArray *values = [NSMutableArray arrayWithCapacity:count];
	for(NSUInteger i = 0; i < count; ++i)
	{
		NSValue *value = [NSValue valueWithAudioValueRange:bytes[i]];
		[values addObject:value];
	}
	
	return [values copy];
}

- (NSArray *)availableEncodeBitRates
{
	return [self availableEncodeBitRatesWithError:nil];
}

- (NSArray *)availableEncodeBitRatesWithError:(NSError **)error
{
	NSData *data = [self dataForProperty:kAudioConverterAvailableEncodeBitRates error:error];
	
	const AudioValueRange *bytes = data.bytes;
	const NSUInteger count = data.length / sizeof(AudioValueRange);
	
	NSMutableArray *values = [NSMutableArray arrayWithCapacity:count];
	for(NSUInteger i = 0; i < count; ++i)
	{
		NSValue *value = [NSValue valueWithAudioValueRange:bytes[i]];
		[values addObject:value];
	}
	
	return [values copy];
}

- (AudioStreamBasicDescription)inputFormat
{
	return [self inputFormatWithError:nil];
}

- (AudioStreamBasicDescription)inputFormatWithError:(NSError **)error
{
	AudioStreamBasicDescription value = { 0 };
	UInt32 size = sizeof(value);
	
	[self getValue:&value size:&size forProperty:kAudioConverterCurrentInputStreamDescription error:error];
	
	return value;
}

- (AudioStreamBasicDescription)outputFormat
{
	return [self outputFormatWithError:nil];
}

- (AudioStreamBasicDescription)outputFormatWithError:(NSError **)error
{
	AudioStreamBasicDescription value = { 0 };
	UInt32 size = sizeof(value);
	
	[self getValue:&value size:&size forProperty:kAudioConverterCurrentOutputStreamDescription error:error];
	
	return value;
}

- (NSArray *)channelMap
{
	return [self channelMapWithError:nil];
}

- (NSArray *)channelMapWithError:(NSError **)error
{
	UInt32 size = 0;
	if (![self getSize:&size writable:NULL forProperty:kAudioConverterChannelMap error:error])
	{
		return nil;
	}
	
	SInt32 *value = malloc(size);
	if (![self getValue:value size:&size forProperty:kAudioConverterChannelMap error:error])
	{
		free(value);
		return nil;
	}

	UInt32 count = size / sizeof(*value);
	NSMutableArray *values = [NSMutableArray arrayWithCapacity:count];
	
	for (UInt32 index = 0; index < count; ++index)
	{
		[values addObject:@(value[index])];
	}
	
	free(value);
	
	return values;
}

- (BOOL)setChannelMap:(NSArray *)channelMap
{
	return [self setChannelMap:channelMap error:nil];
}

- (BOOL)setChannelMap:(NSArray *)channelMap error:(NSError **)error
{
	UInt32 count = (UInt32)channelMap.count;
	UInt32 size = sizeof(SInt32) * count;
	
	SInt32 *value = malloc(size);
	
	UInt32 index = 0;
	for (NSNumber *channel in channelMap)
	{
		value[index] = (SInt32)channel.intValue;
		++index;
	}
	
	BOOL success = [self setValue:value size:size forProperty:kAudioConverterChannelMap error:error];
	
	free(value);
	
	return success;
}

@end
